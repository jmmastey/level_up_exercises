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

  def extract_showing_times
    seek_line_with_date_range
    extract_date_range
    build_date_times if @date_range.present? && @date_range.count == 2
  end

  def build_date_times
    table = extract_days_table
    table.each_slice(2) do |slice|
      showing_times << create_date_time(slice.join(' '))
    end
    showing_times.select { |time| time.present? }
  end

  def create_date_time(table_cell)
    table_cell.gsub!(/[^,]*, /, '')
    table_cell.sub!(/:/, " " + @date_range.first.year.to_s)
    table_cell.sub!(/(pm|am)/, " \\1")
    parse_date_time(table_cell)
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
    return unless DATE_RANGE_REGEXP.match(current_line)
    captures = DATE_RANGE_REGEXP.match(current_line).captures
    start_month, start_day, finish_month, finish_day, year = captures
    @time_zone = ActiveSupport::TimeZone["Central Time (US & Canada)"]
    @date_range << @time_zone.parse("#{start_month} #{start_day}, #{year}")
    @date_range << @time_zone.parse("#{finish_month} #{finish_day}, #{year}")
  end

  def end_of_file?
    @position >= @lines.count
  end

  def current_line
    return '' if end_of_file?
    @lines[@position]
  end
end
