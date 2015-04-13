load 'dinos.rb'
load 'dino_filters.rb'
require 'csv'

def read_data
  # Make an list of dino_class objects
  dino_objects = []

  # Loop over the csv files.  Create dino object and append them to a
  # list of dino objects
  CSV.foreach('dino_csv_list') do |new_file|
    filename = new_file[0]
    dino_data = CSV.read(filename, headers: true, header_converters: :symbol)
    dino_data.each do |row|
      row = translate_headers(row)
      new_dino = Dino.new(row.to_hash)
      dino_objects.push(new_dino)
    end
  end

  # Create DinoFilters object so that all the filter methods can be used
  dino_filter_object = DinoFilters.new(dino_objects)

  # return the dino objects so that they can be queried.
  # [dino_filter_object, dino_objects]
  dino_filter_object
end


def translate_headers(row)
  # Different csv files have different headers (dictionary keys).  We want
  # to translate from the dictionary key into the proper variable.  We
  # translate using the translation dictionary, which maps headers to
  # instance variables.
  translate = {
    genus: :name, 
    period: :period, 
    carnivore: :diet, 
    weight: :weight, 
    walking: :feet, 
    name: :name, 
    continent: :continent,
    diet: :diet,
    weight_in_lbs: :weight, 
    description: :description
  }
  translated_row = {}
  row.each do |key, value|
    puts 'dino keys and value', key, translate[key], value
    # Look up key in the translate dictionary. Map key to correspoding variable name.
    # Set value for the key we just translated.
    translated_row[translate[key]] = value
  end

end
