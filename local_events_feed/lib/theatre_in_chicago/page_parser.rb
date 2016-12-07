require_relative 'image_finder'
require_relative 'description_finder'
require_relative 'showing_finder'
require_relative 'event'
require 'date'

module TheatreInChicago

  class PageParser
    ROOT_LINK = 'http://www.theatreinchicago.com'
    attr_reader :events

    def initialize(node, details_enabled: true)
      @events = []
      extract_events(node)
      add_event_details if details_enabled
    end

    private

    def extract_events(node)
      event_nodes = node.css("td.body a.detailhead")
      event_nodes.each do |event_node|
        extract_event(event_node)
      end
    end

    def extract_event(event_node)
      event = TheatreInChicago::Event.new
      return unless event.name = event_node.text
      return unless event.link = ROOT_LINK + event_node['href']
      return unless event.location = get_location(event_node)
      @events << event
    end

    def get_location(event_node)
      event_node.parent.parent.next_element.css(".body").text.squish
    end

    def add_event_details
      events.each do |event|
        event_node = Nokogiri::HTML(open(event.link))
        add_image(event, event_node)
        add_description(event, event_node)
        add_showings(event, event_node)
      end
    end

    def add_showings(event, event_node)
      showings = ShowingFinder::find(event_node)
      event.showings.concat(showings.to_a)
    end

    def add_image(event, event_node)
      return unless image = ImageFinder::find(event_node)
      event.image = image
    end

    def add_description(event, event_node)
      return unless description = DescriptionFinder::find(event_node)
      event.description = description
    end
  end
end
