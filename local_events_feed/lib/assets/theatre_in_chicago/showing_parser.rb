require_relative 'date_range_builder'

module TheatreInChicago

  class ShowingParser
    TIME_ZONE = ActiveSupport::TimeZone["Central Time (US & Canada)"]
    attr_reader :showings

    def initialize(body, today = Time.now)
      @showings = []
      @lines = body.split(/\n/)
      @position = 0
      @date_range = []
      @today = today
      extract_showings
    end

    protected

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

    def extract_showings
      seek_line_with_date_range
      extract_date_range
      build_showings if date_range_present?
    end

    def seek_line_with_date_range
      until end_of_file? || DateRangeBuilder::date_range_detected?(current_line)
        @position += 1
      end
    end

    def extract_date_range
      @date_range = DateRangeBuilder.new(current_line, @today).build
    end

    def date_range_present?
      @date_range.present? && @date_range.count == 2
    end

    def build_showings
      table = extract_days_table
      table.each_slice(2) do |slice|
        extract_showing_from_table_cell(slice.join(' '))
      end
    end

    def extract_showing_from_table_cell(table_cell)
      warn('Should not be calling this method in base class')
    end

    def add_showing(showing)
      return unless showing.present?
      return unless inside_date_range?(showing)
      showings << showing
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

    def seek_line(pattern)
      until end_of_file? || current_line.match(pattern) do
        @position += 1
      end
      @position
    end

    def end_of_file?
      @position >= @lines.count
    end

    def current_line
      return '' if end_of_file?
      @lines[@position]
    end
  end
end
