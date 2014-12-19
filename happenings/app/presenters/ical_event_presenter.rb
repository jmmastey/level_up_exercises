module ICalEventPresenter
  def self.convert_to_ical(events)
    icalendar = Icalendar::Calendar.new
    events.map do |event|
      icalendar.add_event(event.to_ics)
    end
    calendar.publish
    calendar.to_ical
  end
end
