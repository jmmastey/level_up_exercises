require_relative 'theatre_in_chicago_event'
require_relative 'theatre_in_chicago_showing_parser'
require 'date'

class TheatreInChicagoPageParser
  ROOT_LINK = 'http://www.theatreinchicago.com'
  EVENT_NAME_REGEXP = Regexp.new('<a href="([^"]*)" class="detailhead"[^>]*><strong>([^<]*)</strong></a>');
  BEGIN_OF_LOCATION_REGEXP = Regexp.new('http://www.theatreinchicago.com/theatredetail.php')
  END_OF_LOCATION_REGEXP = Regexp.new('</a>')

  attr_reader :events

  def initialize(body, showings_enabled: true)
    @lines = clean_invalid_utf8_chars(body).split(/\n/)
    @position = 0
    @events = []
    @event = create_new_event
    extract_events
    add_showings if showings_enabled
  end

  private

  def clean_invalid_utf8_chars(text)
    text.chars.select(&:valid_encoding?).join
  end

  def create_new_event
    TheatreInChicagoEvent.new
  end

  def extract_events
    while !reached_end_of_file?
      extract_fields_from_current_line
      check_for_complete_event
      move_to_next_line
    end
  end

  def add_showings
    events.each do |event|
      showings_body = open(event.link).read
      showing_times = TheatreInChicagoShowingParser.new(showings_body).showing_times
      event.showings = showing_times
    end
  end

  def move_to_next_line
    @position += 1
  end

  def check_for_complete_event
    if @event.complete? && location_is_complete?
      @events << @event.clean.clone
      @event = create_new_event
    end
  end

  def extract_fields_from_current_line
    extract_name_from_current_line
    extract_location_from_current_line
  end

  def reached_end_of_file?
    @position >= @lines.count
  end
  
  def current_line
    return '' if reached_end_of_file?
    @lines[@position]
  end

  def extract_location_from_current_line
    return if location_is_complete?
    append_location_from_current_line
  end

  def location_is_complete?
    END_OF_LOCATION_REGEXP.match(@event.location)
  end

  def extract_name_from_current_line
    return unless EVENT_NAME_REGEXP.match(current_line)
    captures = EVENT_NAME_REGEXP.match(current_line).captures
    @event.link = "#{ROOT_LINK}#{captures[0]}"
    @event.name = captures[1]
  end

  def append_location_from_current_line
    if @event.location.blank?
      extract_beginning_of_location_from_current_line
    else
      @event.location += current_line
    end
  end

  def extract_beginning_of_location_from_current_line
    return unless BEGIN_OF_LOCATION_REGEXP.match(current_line)
    @event.location = current_line
  end
end
