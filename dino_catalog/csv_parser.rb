require 'csv'
require_relative 'dinosaur'

class CsvParser
  def self.read_csv_file(file_path)
    csv_file_rows = CSV.read(file_path, headers: true)
    analyze_csv(csv_file_rows)
  end

  def self.analyze_csv(csv_rows)
    headers = csv_rows.headers
    csv_rows.map { |row| Dinosaur.new(get_row_facts(headers, row)) }
  end

  def self.get_row_facts(headers, row)
    headers.each_with_object({}) do |header, fact_hash|
      fact_hash[header.downcase] = row[header]
    end
  end

  private_class_method :analyze_csv, :get_row_facts
end
