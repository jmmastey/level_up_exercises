class Artist < ActiveRecord::Base
  has_many :songs, dependent: :destroy
  has_many :metrics

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
  validates :grooveshark_id, uniqueness: true, allow_nil: true, allow_blank: true
  validates :nbs_id, uniqueness: true, allow_nil: true, allow_blank: true

  def update_metrics(options = {})

    metric_data = nbs_metrics(start_on: options[:start_on], end_on: options[:end_on])
    self.metrics.build(start_on: start_on, end_on: end_on, json_data: metric_data)

    self.save
  end

  private

  def nbs_metrics(options = {})
    start_on = options[:start_on] || 3.months.ago
    end_on = options[:end_on] || Time.now
    update_api_ids
    NextBigSoundLite::Metric.artist(nbs_id, start_on: start_on, end_on: end_on).to_json
  end

  def update_api_ids
    return if nbs_id

    if search_results = NextBigSoundLite::Artist.search(artist.name)
      self.nbs_id = search_results.first.id.to_i
      self.music_brainz_id = search_results.first.music_brainz_id
      self.save
    end
  end
end

# Questions:
# Where does the saving happen? Do I need to do all these selfs?
  # Can I just set the values and save outside?
    # FUTURE: Instead of first, do with lowest levenshtein difference
    # Does NBS already do this?
  # Don't want to continually check for artist that doesn't exist
  #else
  #  self.nbs_id = ""
