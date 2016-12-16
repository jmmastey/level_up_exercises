require 'json'
require_relative "dinosaur"
require_relative "dino_csv_parser"

class Dinosaurs
  attr_reader :collection

  def initialize(dinos = [])
    @collection = dinos
  end

  def small_dinosaurs
    Dinosaurs.new( collection.reject(&:big?) )
  end

  def big_dinosaurs
    Dinosaurs.new( collection.select(&:big?) )
  end

  def biped_dinosaurs
    Dinosaurs.new( collection.select(&:biped?) )
  end

  def carnivorus_dinosaurs
    Dinosaurs.new( collection.select(&:carnivore?) )
  end

  def dinosaurs_from(period)
    Dinosaurs.new( collection.select{|d| d.from?(period)} )
  end

  def search(terms)
    dino_collection = Dinosaurs.new(self.collection)
    terms.each do |katagory, value|
      dino_collection = dino_collection.filter_by(katagory.downcase, value)
    end
    dino_collection
  end

  def display
    collection.each do |dinosaur|
      puts dinosaur
    end  
  end

  def export_json
    collection.map(&:to_h).to_json
  end

  # def add_dino(dinosaur)
  #   collection << dinosaur
  #   self
  # end

  #######  class methods ##########

  def self.from_args(args)
    Dinosaurs.new(args.map{|arg| Dinosaur.new(arg)})
  end

  ############  private instance  #########
  # this should be a private method, the only place it is called is
  # by #search() and there is zero reason why it should be exposed
  # to the world...  but a no method error is thrown when trying
  # to test search while this is private, which I don't understand

  # private
  def filter_by(category, value)
    if DinoCsvParser::RECOGNIZED_ATTRIBUTES.include?(category)
      Dinosaurs.new(
        collection.select do |dino| 
          dino.attribute_value?(
            DinoCsvParser.attribute_from_header(category), 
            value
          )
        end
      )
    else
      Dinosaurs.new( 
        collection.select do |dino| 
          dino.additional_info_value?(category, value)
        end
      )
    end    
  end
end