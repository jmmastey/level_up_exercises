class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :legislator
  validates :legislator_id, presence: true
  validates :user_id, presence: true
end
