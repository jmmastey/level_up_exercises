class Artist < ActiveRecord::Base
  has_many :songs, dependent: :destroy
  has_many :metrics

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
  validates :grooveshark_id, uniqueness: true, allow_nil: true, allow_blank: true
  validates :nbs_id, uniqueness: true, allow_nil: true, allow_blank: true

  after_create :populate_initial_metrics

  def update_metrics
    nbs_service_metrics = get_nbs_metrics(update_start_date)
    process_metrics(nbs_service_metrics)
  end

  def update_start_date
    return 3.months.ago unless metrics
    (metrics.first.recorded_on + 1).to_datetime
  end

  def populate_initial_metrics
    return if metrics.any?
    nbs_services = get_nbs_metrics(3.months.ago)
    process_metrics(nbs_services)
  end

  def process_metrics(nbs_services)
    nbs_services.each do |nbs_service|
      service = Service.find_or_create_by(name: nbs_service["service"]["name"])

      nbs_metrics = nbs_service["metric"]

      nbs_metrics.keys.each do |nbs_category|
        category = Category.find_or_create_by(name: nbs_category)
        nbs_metrics[nbs_category].each do |nbs_date, nbs_value|
          metric = Metric.new(service: service,
                              category: category,
                              value: nbs_value,
                              nbs_date: nbs_date)
          metrics << metric
        end
      end
    end
  end

  def get_nbs_metrics(start_on)
    update_api_ids
    NextBigSoundLite::Metric.artist(nbs_id, start: start_on)
  end

  def update_api_ids
    return if nbs_id

    search_results = NextBigSoundLite::Artist.search(name)
    self.nbs_id = search_results.first.id.to_i
    self.music_brainz_id = search_results.first.music_brainz_id
    save
  end
end
