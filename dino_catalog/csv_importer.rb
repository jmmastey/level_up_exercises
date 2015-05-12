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
    dinos = []
    @raw_dino_info.each do |row|
      row[:name] ||=row[:genus]
      row[:continent] ||= "Africa"
      row[:diet] = "Herbivore" if row[:carnivore] == "No"
      row[:diet] = "Carnivore" if row[:diet] != "Herbivore" || row[:carnivore] == "yes"
      row[:weight] ||= row[:weight_in_lbs]
      row[:weight] = row[:weight].to_i
      dinos <<  Dino.new(row)
    end
    dinos
  end
end
