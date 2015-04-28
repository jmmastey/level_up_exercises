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
    read_data(csv_files)
  end

  def read_data(csv_files)  # csv_files = file containing list of csv filenames
    dino_objects = []

    # Each row in csv file is a separate dino object
    CSV.foreach(csv_files) do |new_file|
      filename = new_file[0]
      dino_data = CSV.read(filename, headers: true, header_converters: lambda { |h| translate_header(h) })
      dino_data.each do |row|
        new_dino = Dino.new(row.to_hash)
        dino_objects.push(new_dino)
      end
    end
    # Create DinoFilters object so that methods in dino_filters can be used
    @dino_filter = DinoFilters.new(dino_objects)
  end

  def translate_header(header_name)
    unless TRANSLATE[header_name.downcase.to_sym]
      raise KeyError,  'Ensure CSV headers are in the translate dictionary.'
    end
    TRANSLATE[header_name.downcase.to_sym]
  end
end
