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
    extract_data(csv_file_path)
    @dinosaurs.concat(@csv_rows.collect { |row| Dinosaur.new(row) })
  end

  def select(key, value)
    DinoCatalog.new(@dinosaurs).filter(key, value)
  end

  def select_larger_than(value)
    DinoCatalog.new(@dinosaurs.select { |dinosaur| dinosaur.larger_than?(value) })
  end

  def select_smaller_than(value)
    DinoCatalog.new(@dinosaurs.select { |dinosaur| dinosaur.smaller_than?(value) })
  end

  def select_hash(args)
    catalog = DinoCatalog.new(dinosaurs)
    args.each { |key, value| catalog.filter(key, value) }
    catalog
  end

  def select_dinosaur(dinosaur_name)
    match = dinosaurs.select { |dino| dino.name.downcase == dinosaur_name.downcase }
    match[0]
  end

  def to_json
    {
      dinosaurs: dinosaurs.map(&:to_hash),
    }.to_json
  end

  private

  def extract_data(csv_file_path)
    @csv_rows = []
    CSV.foreach(csv_file_path, headers: true, header_converters: :symbol) do |row|
      @csv_rows << clean_row(row)
    end
  end

  def clean_row(csv_row)
    return csv_row if (HEADER_NORMALIZE.keys & csv_row.headers).empty?
    (HEADER_NORMALIZE.keys & csv_row.headers).each do |matched_key|
      value = csv_row[matched_key]
      csv_row.delete(matched_key)
      csv_row[HEADER_NORMALIZE[matched_key]] = value
    end
    csv_row
  end
end
