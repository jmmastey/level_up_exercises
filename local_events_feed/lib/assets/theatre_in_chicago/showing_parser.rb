require_relative 'date_range_builder'

module TheatreInChicago

  class ShowingParser
    TIME_ZONE = ActiveSupport::TimeZone["Central Time (US & Canada)"]
    attr_reader :showings

    def initialize(event_node, today = Time.now)
      @node = event_node
      @showings = []
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
      @date_range = DateRangeBuilder.new(@node, @today).build
      build_showings if date_range_present?
    end

    def date_range_present?
      @date_range.present? && @date_range.count == 2
    end

    def build_showings
      return unless table_node = @node.css("table.daysTable td")
      table_node.each_slice(2) do |slice|
        extract_showing_from_table_row(slice)
      end
    end

    def extract_showing_from_table_row(row)
      return if row.count != 2
      extract_showing_from_table_cell("#{row[0].text} #{row[1].text}")
    end

    def extract_showing_from_table_cell(table_cell)
      warn('Should not be calling this method in base class')
    end

    def add_showing(showing)
      return unless showing.present?
      return unless inside_date_range?(showing)
      return if showing.in?(showings)
      showings << showing
    end
  end
end
