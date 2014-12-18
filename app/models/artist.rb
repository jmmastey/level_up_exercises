class Artist < ActiveRecord::Base
  has_many :artworks

  validates :first_name, :last_name, presence: true

  scope :most_recent, -> { order(updated_at: :desc) }

  paginates_per 2

  def full_name
    "#{first_name} #{last_name}"
  end

  def set_thumbnail
    api_instance = ArtsyApiWrapper.new
    thumbnail = api_instance.artist_url
  end
end
