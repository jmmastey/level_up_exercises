require_relative './dinos.rb'
require_relative './dino_filters.rb'
require 'csv'

  def read_data
    dino_objects = []

    # Create dino object from each row in csv file and append to dino_objects list
    CSV.foreach('dino_csv_list') do |new_file|
      filename = new_file[0]
      dino_data = CSV.read(filename, headers: true, header_converters: lambda {|h| translate_header(h) })
      dino_data.each do |row|
        new_dino = Dino.new(row.to_hash)
        dino_objects.push(new_dino)
      end
    end

    # Create DinoFilters object so that methods in dino_filters can be used
    dino_filter_object = DinoFilters.new(dino_objects)

  end


  def translate_header(header_name)
    #translate csv header value to instance variable name in Dino class.
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
    if not translate[header_name.downcase.to_sym]
      raise 'Key Error.  Make sure headers in CSV file are in the translate dictionary.'
    else
      return translate[header_name.downcase.to_sym]
    end
  end
