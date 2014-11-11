class Showing < ActiveRecord::Base
  LOCAL_TIME_ZONE = "Central Time (US & Canada)"
  validates :time, presence: true

  belongs_to :event
  delegate :name, :location, :link, :image, :description, :to => :event

  has_and_belongs_to_many :users

  # self
  def Showing.sort_by_time(showings)
    showings.sort { |a, b| a.time <=> b.time }
  end

  # Look into (move to event || delete)
  def Showing.one_day_only?(showings)
    return false unless showings.present?
    sorted = Showing.sort_by_time(showings)
    sorted.first.time == sorted.last.time
  end

  def to_local_time_s
    time.in_time_zone(LOCAL_TIME_ZONE).strftime('%m/%d/%Y %I:%M %P')
  end

  def pretty_local_date
    time.in_time_zone(LOCAL_TIME_ZONE).strftime('%a, %b %-d, %Y')
  end

  def pretty_local_date_no_dow
    time.in_time_zone(LOCAL_TIME_ZONE).strftime('%b %-d, %Y')
  end

  def pretty_local_dow
    time.in_time_zone(LOCAL_TIME_ZONE).strftime('%a')
  end

  def pretty_local_time
    time.in_time_zone(LOCAL_TIME_ZONE).strftime('%I:%M %P')
  end

  # to_ics
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
