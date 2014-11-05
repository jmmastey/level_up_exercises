class Artist < ActiveRecord::Base
  extend FriendlyId
  friendly_id :nbs_name, use: :slugged

  has_many :songs, dependent: :destroy
  has_many :metrics, -> { order "recorded_on DESC" }
  has_and_belongs_to_many :users

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
  validates :grooveshark_id, uniqueness: true, allow_nil: true, allow_blank: true
  validates :nbs_id, uniqueness: true, allow_nil: true, allow_blank: true

  after_create :update_metrics

  DEFAULTS = [
    "Bassnectar", "Beyonce", "Disclosure", "Jay Z", "Kanye West", "Lady Gaga",
    "Madonna", "Phish", "STS9", "The Rolling Stones"
  ]

  def self.update_all_metrics
    Artist.all.each do |artist|
      artist.update_metrics
    end
  end

  def self.defaults
    default_list = []
    DEFAULTS.each do |name|
      default_list << find_or_create_by_unique_name(name)
    end
    default_list
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
    metric = fan_metrics(service_name).first

    return 0 unless metric

    metric.value
  end

  def fan_metrics(service_name = nil)
    category_name = "fans"
    category_name = "likes" if service_name == "YouTube"

    service = Service.find_by_name(service_name)
    category = Category.find_by_name(category_name)
    metrics.where(category: category, service: service)
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

  def update_metrics
    NbsMetricsProcessor.new(self)
  end

  def graph_metrics(service_name = nil)
    metrics_array = []
    fan_metrics(service_name).reverse.each do |metric|
        metrics_array << [metric.unix_time * 1000, metric.value]
    end
    metrics_array
  end
end
