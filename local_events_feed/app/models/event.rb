require 'icalendar'

class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :location, presence: true
  validates :time, presence: true
  validates :link, presence: true
  has_and_belongs_to_many :users

  def same_as?(other)
    name == other.name && location == other.location && time == other.time
  end

  def has_match_in?(list)
    list.any? { |other| other.same_as?(self) }
  end

  def unique?
    !has_match_in?(Event.all)
  end

  def to_chicago_time_s
    time.in_time_zone("Central Time (US & Canada)").strftime('%m/%d/%Y %I:%M %P')
  end

  def ics
    ical_event = Icalendar::Event.new
    ical_event.uid         = "#{id}"
    ical_event.dtstart     = time
    ical_event.summary     = name
    ical_event.location    = location
    ical_event.description = "#{name} at #{location}"
    ical_event.url         = link
    ical_event.ip_class    = "PRIVATE"
    ical_event
  end
end
