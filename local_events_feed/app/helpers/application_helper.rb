module ApplicationHelper
  def render_calendar_publish(event)
    calendar = Icalendar::Calendar.new
    calendar.add_event(event.ics)
    calendar.publish
    calendar.to_ical
  end
end
