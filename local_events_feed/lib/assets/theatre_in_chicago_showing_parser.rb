require_relative 'theatre_in_chicago_event'

class TheatreInChicagoShowingParser
  DATE_RANGE_REGEXP = Regexp.new('<[^>]*>([a-zA-Z]*) ([0-9]*) - ([a-zA-Z]*) ([0-9]*), ([0-9]*)')
  THRU_RANGE_REGEXP = Regexp.new('<[^>]*>Thru - ([a-zA-Z]*) ([0-9]*), ([0-9]*)')
  DOW_DAYS_REGEXP = Regexp.new('(Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday)');
  DOW_TIME_REGEXP = Regexp.new('([0-9]{1,2}):([0-9]{2})([a|p]m)')
  TIME_ZONE = ActiveSupport::TimeZone["Central Time (US & Canada)"]

  attr_reader :showing_times

  def initialize(body, today = Time.now)
    @showing_times = []
    @lines = body.split(/\n/)
    @position = 0
    @date_range = []
    @today = today
    extract_showing_times
  end

  private

  def start_date
    @date_range[0]
  end

  def finish_date
    @date_range[1]
  end

  def inside_date_range?(time)
    return false unless start_date.present?
    return false unless finish_date.present?
    time.between?(start_date, finish_date)
  end

  def extract_showing_times
    seek_line_with_date_range
    extract_date_range
    build_date_times if date_range_present?
  end

  def date_range_present?
    @date_range.present? && @date_range.count == 2
  end

  def build_date_times
    table = extract_days_table
    table.each_slice(2) do |slice|
      extract_showing_from_table_cell(slice.join(' '))
    end
    showing_times
  end

  def extract_showing_from_table_cell(table_cell)
    if in_dow_format?(table_cell)
      add_showings_from_table_cell_in_dow_format(table_cell)
    else
      add_showing_from_table_cell_in_date_format(table_cell)
    end
  end

  def add_showings_from_table_cell_in_dow_format(table_cell)
    return unless days_of_week = get_dow_format_days(table_cell)
    return unless times_of_day = get_dow_format_time(table_cell)
    matching_dates = days_in_date_range.select { |date| dow_match?(date, days_of_week) }
    showings = cartesian_product(matching_dates, times_of_day)
    showings.each { |showing| add_showing_time(showing) }
  end

  def add_showing_from_table_cell_in_date_format(table_cell)
    add_showing_time(construct_date_time(table_cell, start_date.year))
    add_showing_time(construct_date_time(table_cell, finish_date.year))
  end

  def cartesian_product(dates, times_of_day)
    result = []
    times_of_day.each do |time_of_day|
      result.concat(dates.map { |date| time_zonify(date, time_of_day) })
    end
    result.reject(&:blank?)
  end

  def dow_match?(date, days_of_week)
    Date::DAYNAMES[date.wday].in?(days_of_week)
  end

  def time_zonify(date, time_of_day)
    timestamp = "#{time_of_day[0]}:#{time_of_day[1]}:00 #{time_of_day[2]}"
    TIME_ZONE.parse("#{date.year}-#{date.month}-#{date.day} #{timestamp}")
  end

  def in_dow_format?(text)
    DOW_DAYS_REGEXP.match(text)
  end

  def get_dow_format_days(text)
    text.scan(DOW_DAYS_REGEXP).map(&:first)
  end

  def get_dow_format_time(text)
    text.scan(DOW_TIME_REGEXP)
  end

  def days_in_date_range
    result = []
    date = start_date
    while date <= finish_date
      result << date
      date = date.tomorrow
    end
    result
  end

  def construct_date_time(table_cell, year)
    table_cell.gsub!(/[^,]*, /, '')
    table_cell.sub!(/:/, " " + year.to_s)
    table_cell.sub!(/(pm|am)/, " \\1")
    parse_date_time(table_cell)
  end

  def add_showing_time(time)
    return unless time.present?
    return unless inside_date_range?(time)
    showing_times << time
  end
  
  def parse_date_time(date_time_text)
    TIME_ZONE.parse(date_time_text)
  rescue
    nil
  end

  def extract_days_table
    table_begin = seek_line('class="detailbody"')
    table_end = seek_line('/table')
    table = @lines[table_begin, table_end - table_begin].map { |line| line.squish }
    clean_days_table(table)
  end

  def clean_days_table(table)
    table.map! { |line| line.gsub(/<[^>]*>/, '') }
    table.reject!(&:blank?)
  end

  def seek_line_with_date_range
    while !end_of_file?
      return if /class="detailbody bottomPad"/.match(current_line)
      @position += 1
    end
  end

  def seek_line(pattern)
    while !end_of_file? && !current_line.match(pattern) do
      @position += 1
    end
    @position
  end

  def extract_date_range
    if DATE_RANGE_REGEXP.match(current_line)
      extract_date_range_from_pair
    else
      extract_date_range_from_thru
    end
  end

  def extract_date_range_from_pair
    return unless DATE_RANGE_REGEXP.match(current_line)
    captures = DATE_RANGE_REGEXP.match(current_line).captures
    start_month, start_day, finish_month, finish_day, year = captures
    build_date_range("#{start_month} #{start_day}, #{year}", "#{finish_month} #{finish_day}, #{year}")
  end

  def extract_date_range_from_thru
    return unless THRU_RANGE_REGEXP.match(current_line)
    captures = THRU_RANGE_REGEXP.match(current_line).captures
    finish_month, finish_day, finish_year = captures
    today_month = Date::MONTHNAMES[@today.month]
    build_date_range("#{today_month} #{@today.day}, #{@today.year}", 
                     "#{finish_month} #{finish_day}, #{finish_year}")
  end

  def build_date_range(start_date_s, finish_date_s)
    @date_range << TIME_ZONE.parse(start_date_s)
    @date_range << TIME_ZONE.parse(finish_date_s).since(1.day)
    reduce_start_year_by_one_if_crossed
  end

  def reduce_start_year_by_one_if_crossed
    return if start_date <= finish_date
    @date_range[0] = start_date.ago(1.year)
  end

  def end_of_file?
    @position >= @lines.count
  end

  def current_line
    return '' if end_of_file?
    @lines[@position]
  end
end
