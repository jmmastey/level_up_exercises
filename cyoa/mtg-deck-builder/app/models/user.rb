class User < ActiveRecord::Base
  validates :username, presence: true,
                       uniqueness: true,
                       length: { maximum: 50 }
  VALID_EMAIL_REGEX = /.+@.+\..+/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true,
                       confirmation: true,
                       length: { minimum: 6, maximum: 255 }
end
