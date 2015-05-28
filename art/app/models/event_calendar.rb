class EventCalendar
  def initialize
    @calendar = Icalendar::Calendar.new
    add_calendar_events
  end

  def ical
    @calendar.to_ical
  end

  private

  def add_calendar_events
    calendar_events.each { |event| add_event(event.to_ical) }
  end

  def add_event(event)
    @calendar.event do |e|
      e.dtstart       = event.dtstart
      e.dtend         = event.dtend
      e.summary       = event.summary
      e.description   = event.description
      e.ip_class      = event.ip_class
    end
  end

  def calendar_events
    Performance.upcoming
  end
end
