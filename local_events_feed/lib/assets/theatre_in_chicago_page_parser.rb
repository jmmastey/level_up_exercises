require_relative 'theatre_in_chicago_event'
require 'date'

class TheatreInChicagoPageParser
  attr_reader :events
  TIME_REGEXP = Regexp.new('(\d|\d\d):(\d\d)(a|p)m')

  def initialize(body)
    @lines = body.split(/\n/)
    @position = 0
    @events = []
    @date = ''
    @event = create_new_event
    extract_events
  end

  private

  def create_new_event
    TheatreInChicagoEvent.new(@date)
  end

  def extract_events
    while !reached_end_of_file?
      extract_fields_from_current_line
      check_for_complete_event
    end
  end

  def check_for_complete_event
    if @event.complete?
      @events << @event.clean.clone
      @event = create_new_event
    end
  end

  def extract_fields_from_current_line
    extract_date_from_current_line
    extract_time_from_current_line
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

  def extract_date_from_current_line
    return unless month = extract_month_from_current_line
    return unless /#{month} (\d+), (\d+)/.match(line)
    day, year = /#{month} (\d+), (\d+)/.match(line).captures
    @date = construct_date(month, day, year)
    @event.date = @date
  end

  def extract_time_from_current_line
    return unless TIME_REGEXP.match(line)
    hh, mm, am_pm = TIME_REGEXP.match(line).captures
    set_event_time(hh, mm, am_pm) if valid_time_components(hh, mm, am_pm)
  end

  def extract_location_from_current_line
    return unless @date.present?
    return unless @event.time.blank?
    append_location_from_current_line
  end

  def extract_name_from_current_line
    return unless @date.present?
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

  def construct_date(month, day, year)
    mm = convert_to_mm(month.to_s)
    sprintf("%04d-%02d-%02d", year.to_i, mm, day.to_i)
  end

  def convert_to_mm(month)
    Date::MONTHNAMES.index(month)
  end

  def valid_time_components(hh, mm, am_pm)
    return false unless hh && mm && am_pm
    return false unless (0..12).include?(hh.to_i)
    return false unless (0..59).include?(mm.to_i)
    return false unless ['a', 'p'].include?(am_pm)
    true
  end

  def set_event_time(hh, mm, am_pm)
    halfday = 0
    halfday = 12 if am_pm == 'p'
    @event.time = sprintf("%02d:%02d:00", hh.to_i + halfday, mm)
  end
end
