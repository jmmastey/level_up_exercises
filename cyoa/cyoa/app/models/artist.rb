class Artist < ActiveRecord::Base
  has_many :songs, dependent: :destroy
  has_many :metrics

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
  validates :grooveshark_id, uniqueness: true, allow_nil: true, allow_blank: true
  validates :nbs_id, uniqueness: true, allow_nil: true, allow_blank: true

  after_create :retrieve_initial_metrics 



  def update_metrics #(options = {})
    metric = Metric.new(start_on: 3.months.ago,
                        end_on: Time.now,
                        json_data: nbs_metrics)
    metrics << metric

    save
  end

  #private
  def retrieve_initial_metrics

  end

  def process_metrics
  end

  def nbs_metrics
    update_api_ids
    NextBigSoundLite::Metric.artist(nbs_id, start: 3.months.ago).to_json
  end

  def update_api_ids
    return if nbs_id

    if search_results = NextBigSoundLite::Artist.search(name)
      nbs_id = search_results.first.id.to_i
      music_brainz_id = search_results.first.music_brainz_id
      save
    end
  end
end

# Questions:
# Metrics: save all as json data
#          OR
#          process when retrieve data and save for that particular service
# Where to put callbacks?
