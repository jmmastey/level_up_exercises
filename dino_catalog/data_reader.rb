require_relative './dino.rb'
require_relative './dino_filters.rb'
require 'csv'

class DataReader
  
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
    DinoFilters.new(dino_objects)
  end

  def translate_header(header_name)
    translate = {
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
    if !translate[header_name.downcase.to_sym]
      raise 'Key Error.  Ensure CSV headers are in the translate dictionary.'
    end
    translate[header_name.downcase.to_sym]
  end
end
