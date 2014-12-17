class Event < ActiveRecord::Base
  lookup_for :event_source, symbolize: true,
    scope: :with_source, inverse_scope: :without_source

  def to_ics
    ical_event = Icalendar::Event.new
    ical_event.dstart = date.strftime("%Y%m%d") + time.strftime("T%H%M%S")
    ical_event.summary = title
    ical_event.description = "desc: #{description};  link: #{url}"
    ical_event.ip_class = "PUBLIC"
  end
end
