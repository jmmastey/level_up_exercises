require 'csv'
require_relative 'dinosaur'

class Parser
  def self.read_csv_file(file_path)
    csv_file_rows_array = CSV.read(file_path)
    analyze_csv_array(csv_file_rows_array)
  end

  def self.analyze_csv_array(array)
    dinosaur_array = []
    headers_array = array.shift
    array.each do |row|
      facts = get_facts_from_each_row(headers_array, row)
      dinosaur_array << Dinosaur.new(facts)
    end
    dinosaur_array
  end

  def self.get_facts_from_each_row(headers, row)
    facts = {}
    headers.each do |header|
      facts[header.downcase] = row[headers.index(header)]
    end
    facts
  end
end
