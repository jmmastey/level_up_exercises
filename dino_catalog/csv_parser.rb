require 'csv'
require_relative 'dinosaur'

class Parser
  def self.read_csv_file(file_path)
    csv_file_rows_array = CSV.read(file_path)
    analyze_csv_array(csv_file_rows_array)
  end

  def self.analyze_csv_array(array)
    headers_array = array.shift
    array.each_with_object([]) do |row, dino_array|
      dino_array << Dinosaur.new(get_facts_from_each_row(headers_array, row))
    end
  end

  def self.get_facts_from_each_row(headers, row)
    headers.each_with_object({}) do |header, fact_hash|
      fact_hash[header.downcase] = row[headers.index(header)]
    end
  end
end
