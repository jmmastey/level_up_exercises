class Photo < ActiveRecord::Base

  before_save { self.first = first.downcase }
  before_save { self.last = last.downcase }
  validates :first, presence: true
  validates :last, presence: true
  validates :photo_url,  presence: true, uniqueness: { case_sensitive: false }
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true, length: { maximum: 255 },
  #                 format: { with: VALID_EMAIL_REGEX },
  #                  uniqueness: { case_sensitive: false }

end



