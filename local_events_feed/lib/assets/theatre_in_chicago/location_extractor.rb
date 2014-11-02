require_relative 'event'

module TheatreInChicago
  BEGIN_OF_LOCATION_REGEXP = Regexp.new('http://www.theatreinchicago.com/theatredetail.php')
  END_OF_LOCATION_REGEXP = Regexp.new('</a>')

  module LocationExtractor

    def self.extract(line, event)
      return if complete?(event)
      append_location(line, event)
      event
    end

    def self.complete?(event)
      END_OF_LOCATION_REGEXP.match(event.location)
    end
    
    private
    
    def self.append_location(line, event)
      if event.location.present? || beginning_of_location?(line)
        event.location += line
      end
    end

    def self.beginning_of_location?(line)
      BEGIN_OF_LOCATION_REGEXP.match(line)
    end
  end
end
