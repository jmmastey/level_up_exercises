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

    def to_s
      "#{name}, #{location}, #{link}, #{pretty_image}"
    end
    
    def to_h
      { name: name, 
        location: location, 
        link: link, 
        image: image,
        description: description }
    end

    # Skip Image, Description
    def ==(other)
      name == other.name && location == other.location && link == other.link
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
