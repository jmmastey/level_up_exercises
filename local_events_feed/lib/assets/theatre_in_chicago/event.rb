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

    # Business
    def complete?
      name.present? && location.present? && link.present?
    end

    def to_s
      "#{name}, #{location}, #{link}, #{pretty_image}"
    end
    
    def to_h
      { name: self.name, 
        location: self.location, 
        link: self.link, 
        image: self.image,
        description: self.description }
    end

    def ==(other)
      name == other.name && location == other.location && link == other.link # Skip Image, Description
    end

    # No active support 
    def clean
      @location.squish!
      @description.squish!
      @image.gsub!(/\s+/, '')
      self
    end

    private

    def pretty_image
      return 'no-image' unless image.present?
      image
    end
  end
end
