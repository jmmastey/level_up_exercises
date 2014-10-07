class Metric < ActiveRecord::Base
  belongs_to :artist
  belongs_to :service

  validates :artist, presence: true
  validates :service, presence: true
end
