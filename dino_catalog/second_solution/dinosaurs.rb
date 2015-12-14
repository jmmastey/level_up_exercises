require 'csv'
require_relative "dinosaur"

class Dinosaurs
  attr_reader :collection

  def initialize(dinos = [])
    @collection = dinos
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

  # def search(terms)
  #   collection = Dinosaurs.new(@dinosaurs)
  #   terms.each do |katagory, value|
  #     collection = collection.filter_by(katagory.downcase, value)
  #   end
  #   collection
  # end

  def filter_by(category, value)
    if Dinosaur::SPECIAL_CASE_CSV_COLUMN_HEADERS.include?(category)
      attribute = Dinosaur.attribute_from_special_case_csv_header(category)
      Dinosaurs.new( collection.select{|d| d.attribute_value?(attribute, value)})
    elsif Dinosaur::RECOGNIZED_CSV_COLUMN_HEADERS.include?(category)
      attribute = Dinosaur.attribute_from_recognized_csv_header(category)
      Dinosaurs.new( collection.select{|d| d.attribute_value?(attribute, value)})
    else
      Dinosaurs.new( collection.select{|d| d.additional_info_value?(category, value)})
    end    
  end

  def display
    collection.each do |dinosaur|
      puts dinosaur
    end  
  end

  def add_dino(dinosaur)
    collection << dinosaur
    self
  end

  ###########  class methods  #############

  def self.from_directory(dir_path = "../dino_fact_csvs")
    Dinosaurs.from_files(Dir["#{dir_path}/*"])
  end

  def self.from_files(file_paths)
    file_paths.each_with_object(Dinosaurs.new) do |file_path, dinosaurs|
      CSV.foreach(file_path, 
                  converters: :numeric, 
                  headers: true,
                  :header_converters => lambda {|h| h.downcase}
                  ) do |row|
        dinosaurs.add_dino( Dinosaur.from_csv_row(row) )
      end
    end
  end

end


# collection = Dinosaurs.new
# p collection