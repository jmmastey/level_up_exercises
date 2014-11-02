require 'active_support/all'

module TheatreInChicago

  class DateRangeBuilder

    RANGE_DETECT_REGEXP = Regexp.new('class="detailbody bottomPad"')
    DATE_RANGE_REGEXP = Regexp.new('<[^>]*>([a-zA-Z]*) ([0-9]*) - ([a-zA-Z]*) ([0-9]*), ([0-9]*)')
    THRU_RANGE_REGEXP = Regexp.new('<[^>]*>Thru - ([a-zA-Z]*) ([0-9]*), ([0-9]*)')
    OPEN_RUN_REGEXP = Regexp.new('<[^>]*>Open Run')
    TIME_ZONE = ActiveSupport::TimeZone["Central Time (US & Canada)"]

    def initialize(line, today)
      @line = line;
      @date_range = []
      @today = today
    end

    def self.date_range_detected?(line)
        RANGE_DETECT_REGEXP.match(line)
    end

    def build
      extract_date_range_from_pair || 
      extract_date_range_from_thru ||
      extract_date_range_from_open
    end

    private

    def extract_date_range_from_pair
      return unless DATE_RANGE_REGEXP.match(@line)
      captures = DATE_RANGE_REGEXP.match(@line).captures
      start_month, start_day, finish_month, finish_day, year = captures
      build_date_range("#{start_month} #{start_day}, #{year}", 
                       "#{finish_month} #{finish_day}, #{year}")
    end

    def extract_date_range_from_thru
      return unless THRU_RANGE_REGEXP.match(@line)
      captures = THRU_RANGE_REGEXP.match(@line).captures
      finish_month, finish_day, finish_year = captures
      today_month = Date::MONTHNAMES[@today.month]
      build_date_range("#{today_month} #{@today.day}, #{@today.year}", 
                       "#{finish_month} #{finish_day}, #{finish_year}")
    end

    def extract_date_range_from_open
      return unless OPEN_RUN_REGEXP.match(@line)
      today_month = Date::MONTHNAMES[@today.month]
      next_week = @today.since(1.week);
      next_week_month = Date::MONTHNAMES[next_week.month]
      build_date_range("#{today_month} #{@today.day}, #{@today.year}", 
                       "#{next_week_month} #{next_week.day}, #{next_week.year}")
    end

    def build_date_range(start_date_s, finish_date_s)
      @date_range << TIME_ZONE.parse(start_date_s)
      @date_range << TIME_ZONE.parse(finish_date_s).since(1.day) # end-of-day
      reduce_start_year_by_one_if_crossed
      @date_range
    end

    def reduce_start_year_by_one_if_crossed
      return if @date_range[0] <= @date_range[1]
      @date_range[0] = @date_range[0].ago(1.year)
    end
  end
end
