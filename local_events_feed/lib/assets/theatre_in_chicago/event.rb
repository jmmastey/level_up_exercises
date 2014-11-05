require 'date'
require 'active_support/all'

module TheatreInChicago
  class Event
    attr_accessor :name, :location, :link, :image, :description, :showings

    def initialize
      @name = ''
      @location = ''
      @link = ''
      @image = ''
      @description = 'No description'
      @showings = []
    end

    def complete?
      name.present? && location.present? && link.present?
    end

    def to_s
      "#{name}, #{location}, #{link}, #{pretty_image}"
    end
    
    def match?(other)
      name == other.name && location == other.location && link == other.link # Skip Image, Description
    end

    def clean
      @location.squish!
      @description.squish!
      self
    end

    def to_event_model
      event = ::Event.new(to_h)
      showings.each { |showing| event.add_showing(time: showing) }
      event
    end

    private

    def to_h
      { name: self.name, 
        location: self.location, 
        link: self.link, 
        image: self.image,
        description: self.description }
    end

    def pretty_image
      return 'no-image' unless image.present?
      image
    end
  end
end
