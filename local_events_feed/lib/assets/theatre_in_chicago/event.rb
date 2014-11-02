require 'date'
require 'active_support/all'

module TheatreInChicago
  class Event
    attr_accessor :name, :location, :link, :image, :showings

    def initialize
      @name = ''
      @location = ''
      @link = ''
      @image = ''
      @showings = []
    end

    def complete?
      name.present? && location.present? && link.present?
    end

    def to_s
      "#{name}, #{location}, #{link}, #{pretty_image}"
    end
    
    def match?(other)
      name == other.name && location == other.location && link == other.link # Skip Image
    end

    def clean
      location.gsub!(/<[^>]*>/, '')
      location.squish!
      self
    end

    def to_event_model
      event = ::Event.new(name: self.name, location: self.location, link: self.link, image: self.image)
      showings.each { |showing| event.add_showing(time: showing) }
      event
    end

    private

    def pretty_image
      return 'no-image' unless image.present?
      image
    end
  end
end
