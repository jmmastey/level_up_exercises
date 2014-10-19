class Showing < ActiveRecord::Base
  validates :time, presence: true

  belongs_to :event
  delegate :name, :location, :link, :to => :event

  has_and_belongs_to_many :users

  def Showing.sort_by_time(showings)
    showings.sort { |a, b| a.time <=> b.time }
  end

  def Showing.one_day_only?(showings)
    return false unless showings.present?
    sorted = Showing.sort_by_time(showings)
    sorted.first.time == sorted.last.time
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
