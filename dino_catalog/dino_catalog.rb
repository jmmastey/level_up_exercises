require 'csv'
require 'json'
require_relative "dino_saur"

class DinoCatalog
  attr_reader :dino_collection

  def initialize
    @dino_collection = build_collection
  end

  def build_collection
    rtn = []

    Dir['./dino_fact_csvs/*'].each do |csv_file_path|
      CSV.foreach(csv_file_path, 
                  converters: :numeric, 
                  headers: true,
                  :header_converters => lambda {|h| h.downcase}
                  ) do |row|
        args = DinoSaur.construct_arguments(row)
        rtn << DinoSaur.new(args)
      end
    end
    rtn
  end

  def big_dinosaurs(collection = dino_collection)
    collection.select(&:is_big?)
  end

  def biped_dinosaurs(collection = dino_collection)
    collection.select(&:is_biped?)
  end

  def carnivorus_dinosaurs(collection = dino_collection)
    collection.select(&:is_carnivore?)
  end

  def dinosaurs_from(period)
    dino_collection.select{ |d| d.is_from?(period) }
  end

  def search(terms)
    collection = dino_collection
    terms.each do |katagory, value|
      if DinoSaur::MODEL_ATTRIBUTE_FIELDS.include?(katagory)
        collection = collection.select{ |d| d.has_attribute_value?(katagory, value)}
      elsif DinoSaur::RECOGNIZED_CSV_COLUMN_HEADERS.include?(katagory)
        attribute = DinoSaur.look_up_attribute_by_csv_header(katagory)
        collection = collection.select{ |d| d.has_attribute_value?(attribute, value)}
      else
        collection = collection.select{ |d| d.has_additional_info_value?(katagory, value)}
      end
    end
    collection
  end

  ####  class methods  ####

  def self.collection_to_json(collection)
    collection.map {|d| DinoSaur.hash_dino(d) }.to_json
  end

end

