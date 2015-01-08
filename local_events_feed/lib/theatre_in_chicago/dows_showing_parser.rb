require_relative 'showing_parser'

module TheatreInChicago

  class DowsShowingParser < ShowingParser
    DOW_DAYS_REGEXP = Regexp.new('(Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday)');
    DOW_TIME_REGEXP = Regexp.new('([0-9]{1,2}):([0-9]{2})([a|p]m)')

    private

    def extract_showing_from_table_cell(table_cell)
      if in_dow_format?(table_cell)
        add_showings_from_table_cell_in_dow_format(table_cell)
      end
    end

    def add_showings_from_table_cell_in_dow_format(table_cell)
      return unless days_of_week = get_dow_format_days(table_cell)
      return unless times_of_day = get_dow_format_time(table_cell)
      matching_dates = days_in_date_range.select { |date| dow_match?(date, days_of_week) }
      showings = cartesian_product(matching_dates, times_of_day)
      showings.each { |showing| add_showing(showing) }
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
      date_range(start_date, finish_date, 1.day)
    end

    def date_range(start, finish, step)
      (start.to_i..finish.to_i).step(step.to_i).map { |sec| Time.at(sec) }
    end
  end
end
