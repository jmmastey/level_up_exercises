require 'date'
require 'active_support/all'

module TheatreInChicago
  class Event
    attr_accessor :name, :location, :link, :showings

    def initialize
      @name = ''
      @location = ''
      @link = ''
      @showings = []
    end

    def complete?
      name.present? && location.present? && link.present?
    end

    def to_s
      "#{name}, #{location}, #{link}"
    end
    
    def match?(other)
      name == other.name && location == other.location && link == other.link
    end

    def clean
      location.gsub!(/<[^>]*>/, '')
      location.squish!
      self
    end

    def to_event_model
      event = ::Event.new(name: self.name, location: self.location, link: self.link)
      showings.each { |showing| event.add_showing(time: showing) }
      event
    end
  end
end
