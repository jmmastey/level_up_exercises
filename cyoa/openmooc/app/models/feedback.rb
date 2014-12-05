class Feedback < ActiveRecord::Base
  validates :message, presence: true, allow_blank: false
  validates :subject, presence: true, allow_blank: false
  belongs_to :user
end
