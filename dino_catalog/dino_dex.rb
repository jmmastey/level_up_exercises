require_relative "file_finder"
require_relative "dino_catalog"
require_relative "dinosaur"

require "csv"
require "json"

class DinoDex
  attr_accessor :dinosaurs

  HEADER_NORMALIZE = {
    genus:          :name,
    carnivore:      :diet,
    weight_in_lbs:  :weight,
  }

  def initialize
    @dinosaurs = []
  end

  def import_csv_file(csv_file_path)
    extract_rows(csv_file_path)
    normalize_headers(@csv_rows)
    @csv_rows.each_index { |index| dinosaurs << create_dinosaur(@csv_rows[index]) }
  end

  def empty?
    dinosaurs.length == 0
  end

  def select(key, value)
    DinoCatalog.new(dinosaurs).filter(key, value)
  end

  def select_larger_than(value)
    DinoCatalog.new(dinosaurs.select { |dinosaur| dinosaur.larger_than?(value) })
  end

  def select_smaller_than(value)
    DinoCatalog.new(dinosaurs.select { |dinosaur| dinosaur.smaller_than?(value) })
  end

  def select_hash(args)
    catalog = DinoCatalog.new(dinosaurs)
    args.each { |key, value| catalog.filter(key, value) }
    catalog
  end

  def select_dinosaur(dinosaur_name)
    dinosaurs.each do |dinosaur|
      return dinosaur if dinosaur.name.downcase == dinosaur_name.downcase
    end
    nil
  end

  def export_json
    {
      "dinosaurs" => dinosaurs.map(&:export_hash),
    }.to_json
  end

  private

  def extract_rows(csv_file_path)
    CSV.foreach(csv_file_path, headers: true, header_converters: :symbol) do |row|
      (@csv_rows ||= []) << row
    end
  end

  def normalize_headers(rows)
    rows.each do |row|
      HEADER_NORMALIZE.each do |old_header, new_header|
        next unless row.header?(old_header)
        row_value = row[old_header]
        row.delete(old_header)
        row[new_header] = row_value
      end
    end
  end

  def create_dinosaur(csv_row)
    dinosaur = Dinosaur.new
    dinosaur.diet         = csv_row[:diet]
    dinosaur.name         = csv_row[:name]
    dinosaur.period       = csv_row[:period]
    dinosaur.weight       = csv_row[:weight]
    dinosaur.walk_type    = csv_row[:walking]
    dinosaur.location     = csv_row[:continent]
    dinosaur.description  = csv_row[:description]
    dinosaur
  end
end
