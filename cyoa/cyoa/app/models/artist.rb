class Artist < ActiveRecord::Base
  has_many :songs, dependent: :destroy
  has_many :metrics
  has_and_belongs_to_many :users

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
  validates :grooveshark_id, uniqueness: true, allow_nil: true, allow_blank: true
  validates :nbs_id, uniqueness: true, allow_nil: true, allow_blank: true

  after_create :populate_initial_metrics

  default_scope -> { order('name ASC') }

  def self.update_all_metrics
    Artist.all.each do |artist|
      artist.update_metrics
    end
  end

  def self.defaults
    [ find_or_create_by_unique_name("Beyonce"),
      find_or_create_by_unique_name("Jay-Z"),
      find_or_create_by_unique_name("Paul Simon"),
      find_or_create_by_unique_name("Bassnectar"),
      find_or_create_by_unique_name("The Rolling Stones"),
      find_or_create_by_unique_name("Alison Krauss"),
      find_or_create_by_unique_name("Kanye West"),
      find_or_create_by_unique_name("Lady Gaga"),
      find_or_create_by_unique_name("Madonna"),
      find_or_create_by_unique_name("Justice"),
      find_or_create_by_unique_name("Taylor Swift"),
      find_or_create_by_unique_name("Prince")
    ]
  end

  def self.yonce
    find_or_create_by_unique_name("Beyonce")
  end

  def self.find_by_unique_name(name)
    Artist.where("lower(name) =?", name.downcase).first
  end

  def self.find_or_create_by_unique_name(name)
    artist = Artist.find_by_unique_name(name)
    if artist
      artist.update_metrics
      return artist
    end
    Artist.create(name: name)
  end

  def fan_count(service_name = nil)
    category_name = "fans"
    category_name = "likes" if service_name == "YouTube"

    service = Service.find_by_name(service_name)
    category = Category.find_by_name(category_name)
    metric = metrics.where(category: category, service: service).first

    return 0 unless metric

    metric.value
  end

  def update_metrics
    yesterday = Time.now.to_date - 1
    return if update_start_date >= yesterday
    nbs_service_metrics = get_nbs_metrics(update_start_date)
    process_metrics(nbs_service_metrics)
  end

  private

  def update_start_date
    return 3.months.ago if metrics.empty?
    (metrics.first.recorded_on + 1).to_datetime
  end

  def populate_initial_metrics
    return if metrics.any?
    nbs_services = get_nbs_metrics(3.months.ago)
    process_metrics(nbs_services)
  end

  def process_metrics(nbs_services)
    return if nbs_services.blank?
    new_metrics = []
    cur_time = Time.now

    nbs_services.each do |nbs_service|
      service = Service.find_or_create_by(name: nbs_service["service"]["name"])

      nbs_metrics = nbs_service["metric"]

      unless nbs_metrics.blank?
        nbs_metrics.keys.each do |nbs_category|
          category = Category.find_or_create_by(name: nbs_category)
          nbs_metrics[nbs_category].each do |nbs_date, nbs_value|
            new_metrics.push "(#{self.id}, #{category.id}, #{service.id}, #{nbs_value}, '#{nbs_date}', '#{recorded_on(nbs_date)}', '#{cur_time}', '#{cur_time}')"
          end
        end
      end
    end

    return unless new_metrics.any?

    sql_insertion_records = "INSERT INTO metrics (artist_id, category_id, service_id, value, nbs_date, recorded_on, created_at, updated_at) VALUES #{new_metrics.join(", ")}"
    ActiveRecord::Base.connection.execute sql_insertion_records
  end

  def get_nbs_metrics(start_on = 3.months.ago)
    update_api_ids
    NextBigSoundLite::Metric.artist(nbs_id, start: start_on)
  end

  def update_api_ids
    return if nbs_id

    search_results = NextBigSoundLite::Artist.search(name)
    return if search_results.blank?

    artist = search_results.first

    self.nbs_id = artist.id.to_i
    self.nbs_name = artist.name
    self.music_brainz_id = artist.music_brainz_id
    save
  end

  def recorded_on(nbs_date)
    sec_in_day = 86400
    date_unix_days = nbs_date.to_i
    date_unix_sec = date_unix_days * sec_in_day
    Time.at(date_unix_sec)
  end
end
