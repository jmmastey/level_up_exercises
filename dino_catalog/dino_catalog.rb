require 'csv'
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
    #terms ## {diet: carnivore, locomotion: quadraped...}
    terms.each do |k, v|
      if DinoSaur::MODEL_ATTRIBUTE_FIELDS.include?(k)
        # search main
        dino_collection.select{ |d| d.has_attribute_value?(k, v)}
      else
        # search additional info
        puts "search additional info"
      end
    end


  end



end