require 'csv'
require './dino.rb'

class CsvImporter
  def initialize(input_files)
    @raw_dino_info = input_files.reduce([]) { |a, f| a + import_csv_file(f) }
  end

  def import_csv_file(filename)
    csv = []
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      csv << row
    end
    csv
  end

  def create_dinos
    @raw_dino_info.map do |row|
      row[:name] ||= row[:genus]
      row[:continent] ||= "Africa"
      row = process_weight_field(row)
      row = process_diet_field(row)
      Dino.new(row)
    end
  end

  def process_weight_field(row)
    row[:weight] ||= row[:weight_in_lbs]
    row[:weight] = row[:weight].to_i
    row
  end

  def process_diet_field(row)
    row[:diet] = (row[:carnivore] == "No") ? "Herbivore" : "Carnivore"
    row[:diet] = "Carnivore" if row[:diet] != "Herbivore"
    row
  end
end
