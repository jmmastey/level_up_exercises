class Photo < ActiveRecord::Base
  validates :first, presence: true
  validates :last, presence: true
  validates :photo_url,  presence: true, uniqueness: { case_sensitive: false }
end
