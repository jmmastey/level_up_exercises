require_relative 'event'
require_relative 'date_list_showing_parser'
require_relative 'dows_showing_parser'
require_relative 'name_and_link_extractor'
require_relative 'location_extractor'
require_relative 'image_finder'
require 'date'

module TheatreInChicago

  class PageParser

    attr_reader :events

    @@extractors = [ NameAndLinkExtractor, LocationExtractor]

    @@showing_parsers = [ TheatreInChicago::DateListShowingParser,
                          TheatreInChicago::DowsShowingParser ]

    def initialize(body, showings_enabled: true)
      @lines = clean_invalid_utf8_chars(body).split(/\n/)
      @position = 0
      @events = []
      @event = create_new_event
      extract_events
      add_showings_and_image if showings_enabled
    end

    private

    def clean_invalid_utf8_chars(text)
      text.chars.select(&:valid_encoding?).join
    end

    def create_new_event
      Event.new
    end

    def extract_events
      while !reached_end_of_file?
        extract_fields_from_current_line
        check_for_complete_event
        move_to_next_line
      end
    end

    def move_to_next_line
      @position += 1
    end

    def check_for_complete_event
      return unless @@extractors.all? { |extractor| extractor.complete?(@event) }
      @events << @event.clean.clone
      @event = create_new_event
    end

    def extract_fields_from_current_line
      @@extractors.each { |extractor| extractor.extract(current_line, @event) }
    end

    def reached_end_of_file?
      @position >= @lines.count
    end
    
    def current_line
      return '' if reached_end_of_file?
      @lines[@position]
    end

    def add_showings_and_image
      events.each do |event|
        showings_body = open(event.link).read
        @@showing_parsers.each { |parser| event.showings.concat(parser.new(showings_body).showings) }
        add_image(event, showings_body)
      end
    end

    def add_image(event, showings_body)
      return unless image = ImageFinder::find(showings_body)
      event.image = image
    end
  end
end
