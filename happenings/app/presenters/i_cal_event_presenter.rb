module ICalEventPresenter
  def self.call(events)
    ical = Icalendar::Calendar.new
    events.each { |event| ical.add_event(event.to_ics) }
    ical.publish
    ical.to_ical
  end
end
