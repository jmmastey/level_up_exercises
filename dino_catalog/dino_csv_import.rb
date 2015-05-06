require 'csv'
require './dino_class.rb'

class CsvImporter
  def initialize(input_files)
    @raw_dino_info = Array[]
    input_files.each { |fname| @raw_dino_info += import_csv_file(fname) }
    @raw_dino_info
  end

  def import_csv_file(filename)
    csv = Array[]
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      csv << row
    end
    csv
  end

  def create_dinos
    @dinos = Array[]
    @raw_dino_info.each_with_index do |row, i|
      row[:name] = row[:genus] unless row[:genus].nil?
      row[:continent] = "Africa" if row[:continent].nil?
      row[:diet] = "Herbivore" if row[:carnivore] == "No"
      row[:diet] = "Carnivore" if row[:diet] != "Herbivore" || row[:carnivore] == "yes"
      @dinos[i] = Dino.new(row)
    end
    @dinos
  end
end
