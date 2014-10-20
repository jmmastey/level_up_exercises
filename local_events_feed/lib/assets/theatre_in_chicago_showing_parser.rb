require_relative 'theatre_in_chicago_event'

class TheatreInChicagoShowingParser
  DATE_RANGE_REGEXP = Regexp.new('<[^>]*>([a-zA-Z]*) ([0-9]*) - ([a-zA-Z]*) ([0-9]*), ([0-9]*)')

  attr_reader :showing_times

  def initialize(body)
    @showing_times = []
    @lines = body.split(/\n/)
    @position = 0
    @date_range = []
    @time_zone = ActiveSupport::TimeZone["Central Time (US & Canada)"]
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
    start_date <= time && time <= finish_date
  end

  def extract_showing_times
    seek_line_with_date_range
    extract_date_range
    build_date_times if @date_range.present? && @date_range.count == 2
  end

  def build_date_times
    table = extract_days_table
    table.each_slice(2) do |slice|
      extract_showing_from_table_cell(slice.join(' '))
    end
    showing_times
  end

  def extract_showing_from_table_cell(table_cell)
    add_showing_time(construct_date_time(table_cell, start_date.year))
    add_showing_time(construct_date_time(table_cell, finish_date.year))
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
    @time_zone.parse(date_time_text)
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
    table.select! { |line| line.present? }
    table
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
    return false unless DATE_RANGE_REGEXP.match(current_line)
    captures = DATE_RANGE_REGEXP.match(current_line).captures
    start_month, start_day, finish_month, finish_day, year = captures
    build_date_range("#{start_month} #{start_day}, #{year}", "#{finish_month} #{finish_day}, #{year}")
    true
  end

  def build_date_range(start_date_s, finish_date_s)
    @time_zone = ActiveSupport::TimeZone["Central Time (US & Canada)"]
    @date_range << @time_zone.parse(start_date_s)
    @date_range << @time_zone.parse(finish_date_s)
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
