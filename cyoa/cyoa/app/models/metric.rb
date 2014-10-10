class Metric < ActiveRecord::Base
  belongs_to :artist
  belongs_to :service
  belongs_to :category

  validates :artist, presence: true
  validates :service, presence: true
  validates :value, presence: true
  #validates :category, presence: true
end
