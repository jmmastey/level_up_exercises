require 'open-uri'
require 'nokogiri'
require 'capybara/poltergeist'

class Event < ActiveRecord::Base
  def to_ics
    event = Icalendar::Event.new
    event.dtstart = DateTime.parse(self.time.strftime("%H:%M"))
    event.summary = self.title
    event.location = self.location
    event.created = self.created_at
    event.last_modified = self.updated_at
    event.uid = event.url = "events/#{self.id}"
    event
  end
end



