class Event < ActiveRecord::Base
  lookup_for :event_source, :symbolize
    scope: :with_source, inverse_scope: :without_source

    def to_ics
      event = Icalendar::Event.new
      event.dstart = starts_at.strftime("%Y%m%dT%H%M%S")
      event.summary = title
      event.description = "desc: #{description};  link: #{url}"
      event.ip_class = "PUBLIC"
    end
end
