require_relative "FileFinder"
require_relative "DinoCatalog"
require_relative "Dinosaur"

require "csv"
require "json"

class DinoDex

  attr_accessor :dinosaurs

  HEADER_NORMALIZE = {
    "genus"         => "name",
    "carnivore"     => "diet",
    "weight_in_lbs" => "weight",
  }

  def initialize
    @dinosaurs = []
  end

  def import_csv_file(csv_file_path)
    @csv_rows = []
    CSV.foreach(csv_file_path, {headers: true, header_converters: :symbol}) do |row|
      normalize_headers(row)
      @csv_rows << row
    end

    @csv_rows.each_index do |index|
      dinosaurs << generate_dinosaur(@csv_rows[index])
    end
  end

  def normalize_headers(csv_row)
    HEADER_NORMALIZE.each do |old_header, new_header|
      next unless csv_row.header?(old_header.to_sym)
      csv_row.each do |row_header, row_value|
        next unless row_header.to_s == old_header
        csv_row.delete(old_header.to_sym)
        csv_row[new_header.to_sym] = row_value
      end
    end
  end

  def generate_dinosaur(csv_row)
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

  def empty?
    return dinosaurs.length == 0
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
    args.each do |key, value|
      catalog.filter(key, value)
    end
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
      "dinosaurs" => dinosaurs.map(&:export_hash)
    }.to_json
  end
end