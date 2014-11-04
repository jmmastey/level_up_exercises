class NbsMetricsProcessor
  attr_reader :artist, :cur_time

  def initialize(artist)
    @artist = artist
    @new_metrics = []
    @cur_time = Time.now
    update_metrics
  end

  def update_metrics
    yesterday = Time.now.to_date - 1
    return if start_date_for_update >= yesterday

    service_metrics = get_nbs_metrics(start_date_for_update)
    process_metrics(service_metrics)
    store_processed_metrics
  end

  def start_date_for_update
    return 3.months.ago if artist.metrics.blank?
    (artist.metrics.first.recorded_on + 1).to_datetime
  end

  def process_metrics(service_metrics)
    return if service_metrics.blank?

    service_metrics.each do |nbs_service|
      process_service(nbs_service)
    end
  end

  def process_service(nbs_service)
    service = Service.find_or_create_by(name: nbs_service["service"]["name"])
    nbs_metrics = nbs_service["metric"]

    unless nbs_metrics.blank?
      nbs_metrics.keys.each do |nbs_category|
        category = Category.find_or_create_by(name: nbs_category)

        nbs_metrics[nbs_category].each do |nbs_date, nbs_value|
          @new_metrics.push "(#{artist.id}, #{category.id}, #{service.id}, #{nbs_value}, '#{nbs_date}', '#{date_recorded(nbs_date)}', '#{cur_time}', '#{cur_time}')"
        end
      end
    end
  end

  def store_processed_metrics
    return unless @new_metrics.any?

    sql_insertion_records = "INSERT INTO metrics (artist_id, category_id, service_id, value, nbs_date, recorded_on, created_at, updated_at) VALUES #{@new_metrics.join(", ")}"
    ActiveRecord::Base.connection.execute sql_insertion_records
  end


  def get_nbs_metrics(start_on = 3.months.ago)
    artist.update_api_ids
    return unless artist.nbs_id
    NextBigSoundLite::Metric.artist(artist.nbs_id, start: start_on)
  end 

  def date_recorded(nbs_date)
    sec_in_day = 86400
    date_unix_sec = nbs_date.to_i * sec_in_day
    Time.at(date_unix_sec)
  end
end





















