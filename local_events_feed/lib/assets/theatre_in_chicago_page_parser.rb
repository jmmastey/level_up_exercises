require 'date'
require 'active_support/all'

class TheatreInChicagoPageParser
  class Event
    attr_accessor :name, :location, :date, :time

    def initialize
      @date = ''
      reset
    end
    
    def reset
      @name = ''
      @location = ''
      @time = ''
    end

    def full?
      @date.present? && @time.present? && @name.present? && @location.present?
    end

    def to_s
      "#{@date}, #{@time}, #{@name}, #{@location}"
    end

    def clean
      @location.gsub!(/<[^>]*>/, '')
      @location.gsub!(/\s+/, ' ')
      @location.strip!
    end
  end

  attr_reader :events

  def initialize(body)
    @lines = body.split(/\n/)
    @position = 0
    @date = ""
    @event = Event.new
    @events = []
    extract_events
  end

  private

  def extract_events
    while !reached_end_of_file?
      extract_fields_from_current_line
      if @event.full?
        @event.clean
        @events << @event.clone
        @event.reset
      end
    end
  end

  private

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
    month = extract_month_from_current_line
    return unless month
    day, year = /#{month} (\d+), (\d+)/.match(line).captures
    @event.date = construct_date(month, day, year)
  end

  def extract_time_from_current_line
    return unless /(\d|\d\d):(\d\d)(a|p)m/.match(line)
    hh, mm, am_pm = /(\d|\d\d):(\d\d)(a|p)m/.match(line).captures
    set_event_time(hh, mm, am_pm) if valid_time_components(hh, mm, am_pm)
  end

  def extract_location_from_current_line
    return if @event.date.empty?
    return unless @event.time.empty?
    append_location_from_current_line
  end

  def extract_name_from_current_line
    return if @event.date.empty?
    match = /<a href=\'http:\/\/www.theatreinchicago.com\/.*\'>(.*)<\/a>/.match(line)
    return unless match
    @event.name = match.captures[0]
  end

  def append_location_from_current_line
    if @event.location.empty?
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
