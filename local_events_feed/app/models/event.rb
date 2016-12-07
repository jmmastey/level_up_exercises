require 'icalendar'

class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :location, presence: true
  validates :link, presence: true
  validates_uniqueness_of :name, :scope => [:location, :link]

  has_many :showings, dependent: :destroy

  scope :sorted, -> { order( :name => :asc ) }
end
