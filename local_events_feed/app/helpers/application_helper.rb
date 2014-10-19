module ApplicationHelper
  def render_calendar_publish(showing)
    calendar = Icalendar::Calendar.new
    calendar.add_event(showing.ics)
    calendar.publish
    calendar.to_ical
  end
end
