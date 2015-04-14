require_relative './dino.rb'
require_relative './dino_filters.rb'
require 'csv'

class DataReader
  
  def initialize(csv_list_file)
    #Input is a file containing a list of csv filenames
    @csv_list_file = csv_list_file
  end

  def read_data
    dino_objects = []

    # Create dino object from each row in csv file and append to dino_objects list
    CSV.foreach(@csv_list_file) do |new_file|
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
    # Need to translate csv header value to instance variable name in Dino class.
    translate = {
      genus: :name,
      period: :period,
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
    else
      return translate[header_name.downcase.to_sym]
    end
  end

end 
