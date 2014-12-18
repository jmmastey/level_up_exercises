class Artist < ActiveRecord::Base
  validates :first_name, :last_name, presence: true

  scope :most_recent, -> { order(updated_at: :desc) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def set_thumbnail
    api_instance = ArtsyApiWrapper.new
    thumbnail = api_instance.artist_url
  end
end
