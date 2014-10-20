require_relative 'theatre_in_chicago_event'
require_relative 'theatre_in_chicago_showing_parser'
require 'date'

class TheatreInChicagoPageParser
  attr_reader :events

  def initialize(body, showings_enabled: true)
    @lines = body.split(/\n/)
    @position = 0
    @events = []
    @event = create_new_event
    extract_events
    add_showings if showings_enabled
  end

  private

  def create_new_event
    TheatreInChicagoEvent.new
  end

  def extract_events
    while !reached_end_of_file?
      extract_fields_from_current_line
      check_for_complete_event
    end
  end

  def add_showings
    events.each do |event|
      showings_body = open(event.link).read
      showing_times = TheatreInChicagoShowingParser.new(showings_body).showing_times
      event.showings = showing_times
    end
  end

  def check_for_complete_event
    if @event.complete? && /<br>/.match(@event.location)
      @events << @event.clean.clone
      @event = create_new_event
    end
  end

  def extract_fields_from_current_line
    extract_location_from_current_line
    extract_name_from_current_line
    @position += 1
  end

  def reached_end_of_file?
    @position >= @lines.count
  end
  
  def line
    return '' if reached_end_of_file?
    @lines[@position]
  end

  def extract_location_from_current_line
    append_location_from_current_line
  end

  def extract_name_from_current_line
    match = /<a href=\'(http:\/\/www.theatreinchicago.com\/.*)\'>(.*)<\/a>/.match(line)
    return unless match && match.captures.count == 2
    @event.link = match.captures[0]
    @event.name = match.captures[1]
  end

  def append_location_from_current_line
    if @event.location.blank?
      extract_beginning_of_location_from_current_line
    else
      @event.location += line
    end
  end

  def extract_beginning_of_location_from_current_line
    return unless /<span class="detailbody">(.*)/.match(line)
    @event.location = line
  end

  def extract_month_from_current_line
    /January|February|March|April|May|June|July|August|September|October|November|December/.match(line)
  end
end
