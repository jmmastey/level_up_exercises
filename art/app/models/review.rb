class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :performance

  validates :user, presence: true
  validates :performance, presence: true
  validates :rating, presence: true, numericality: true
end
