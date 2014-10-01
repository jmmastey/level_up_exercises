class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :location, presence: true
  validates :when, presence: true
  has_and_belongs_to_many :users
end
