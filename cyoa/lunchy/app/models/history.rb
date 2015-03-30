class History < ActiveRecord::Base
  belongs_to :user
  has_one :venue
  validates :venue_id, presence: true
  validates :visited, presence: true
  validates :user_id, presence: true
end
