class Event < ActiveRecord::Base
  validates :title, :time, :date, :description, :event_source, presence: true
  validates :title, length: { minimum: 4 }
  validates :description, length: { minimum: 1 }

  lookup_for :event_source, symbolize: true,
    scope: :with_source, inverse_scope: :without_source

  def to_ics
    Icalendar::Event.new.tap do |ical_event|
      ical_event.dtstart = date.strftime("%Y%m%d") + time.strftime("T%H%M%S")
      ical_event.summary = title
      ical_event.description = "desc: #{description};  link: #{url}"
      ical_event.ip_class = "PUBLIC"
    end
  end
end
