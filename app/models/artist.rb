class Artist < ActiveRecord::Base
  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def set_thumbnail
    api_instance = ArtsyApiWrapper.new
    thumbnail = api_instance.artist_url
  end
end
