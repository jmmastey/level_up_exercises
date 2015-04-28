require './dino.rb'
require './dino_filters.rb'
require 'csv'

class DataReader
  attr_reader :dino_filter

  TRANSLATE = {
    genus: :name,
    period: :era,
    carnivore: :diet,
    weight: :weight,
    walking: :walking_style,
    name: :name,
    continent: :continent,
    diet: :diet,
    weight_in_lbs: :weight,
    description: :description,
  }

  def initialize(csv_files)
    dino_data = read_data(csv_files)
    create_dino_filter_object(dino_data)
  end

  private

  def read_data(file_list)
    dino_data = []
    file_list.each do |file|
      new_data = CSV.read(file, headers: true, header_converters: lambda { |h| translate_header(h) } )
      dino_data << new_data.map { |row| row.to_hash}
    end
    dino_data.flatten!
  end

  def create_dino_filter_object(dino_data)
    dino_objects = []
    dino_data.each do |dino_info|
      dino_objects << Dino.new(dino_info)
    end
    # DinoFilters object needed so that methods in dino_filters can be used
    @dino_filter = DinoFilters.new(dino_objects)
  end

  def translate_header(header_name)
    unless TRANSLATE[header_name.downcase.to_sym]
      raise KeyError,  'Ensure CSV headers are in the translate dictionary.'
    end
    TRANSLATE[header_name.downcase.to_sym]
  end
end
