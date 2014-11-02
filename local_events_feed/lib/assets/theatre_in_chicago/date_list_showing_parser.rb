require_relative 'showing_parser'

module TheatreInChicago

  class DateListShowingParser < ShowingParser

    private

    def extract_showing_from_table_cell(table_cell)
      add_showing_from_table_cell_in_date_format(table_cell)
    end

    def add_showing_from_table_cell_in_date_format(table_cell)
      add_showing(construct_date_time(table_cell, start_date.year))
      add_showing(construct_date_time(table_cell, finish_date.year))
    end

    def construct_date_time(table_cell, year)
      cell = table_cell.clone
      cell.gsub!(/[^,]*, /, '')
      cell.sub!(/:/, " " + year.to_s)
      cell.sub!(/(pm|am)/, " \\1")
      parse_date_time(cell)
    end

    def parse_date_time(date_time_text)
      TIME_ZONE.parse(date_time_text)
    rescue
      nil
    end
  end
end
