class Photo < ActiveRecord::Base

  before_save { self.first = first }
  before_save { self.last = last }
  validates :first, presence: true
  validates :last, presence: true
  validates :photo_url,  presence: true, uniqueness: { case_sensitive: false }
 
end



