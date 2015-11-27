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
        #rtn << DinoSaur.new(args)
      end

    end

  end

  def big_dinosaurs

  end

  def biped_dinosaurs

  end

  def carnivorus_dinosaurs

  end

  def dinosaurs_from(period)

  end

  def search(terms)
  end



end