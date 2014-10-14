class Artist < ActiveRecord::Base
  has_many :songs, dependent: :destroy
  has_many :metrics

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
  validates :grooveshark_id, uniqueness: true, allow_nil: true, allow_blank: true
  validates :nbs_id, uniqueness: true, allow_nil: true, allow_blank: true

  after_create :populate_initial_metrics

  def populate_initial_metrics
    return if metrics.any?
    nbs_services = get_nbs_metrics(3.months.ago)
    process_metrics(nbs_services)
  end

  def update_metrics
    yesterday = Time.now.to_date - 1
    return if update_start_date >= yesterday
    nbs_service_metrics = get_nbs_metrics(update_start_date)
    process_metrics(nbs_service_metrics)
  end

  def update_start_date
    return 3.months.ago if metrics.empty?
    (metrics.first.recorded_on + 1).to_datetime
  end

  def process_metrics(nbs_services)
    new_metrics = []
    cur_time = Time.now

    nbs_services.each do |nbs_service|
      service = Service.find_or_create_by(name: nbs_service["service"]["name"])

      nbs_metrics = nbs_service["metric"]

      nbs_metrics.keys.each do |nbs_category|
        category = Category.find_or_create_by(name: nbs_category)
        nbs_metrics[nbs_category].each do |nbs_date, nbs_value|
          new_metrics.push "(#{self.id}, #{category.id}, #{service.id}, #{nbs_value}, '#{nbs_date}', '#{recorded_on(nbs_date)}', '#{cur_time}', '#{cur_time}')"
        end
      end
    end

    sql_insertion_records = "INSERT INTO metrics (artist_id, category_id, service_id, value, nbs_date, recorded_on, created_at, updated_at) VALUES #{new_metrics.join(", ")}"
    ActiveRecord::Base.connection.execute sql_insertion_records
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

  def recorded_on(nbs_date)
    sec_in_day = 86400
    date_unix_days = nbs_date.to_i
    date_unix_sec = date_unix_days * sec_in_day
    Time.at(date_unix_sec)
  end
end
