require 'csv'
require_relative 'dinosaur'

module DinosaurDeserializer
  module_function

  #
  # This Hash holds the built-in dinosaur formats that can be accessed by name.
  # You can select the formats through the parameter passed to CSV::new().
  #
  # This Hash is intentionally left unfrozen and users should feel free to add
  # values to it.
  #
  # <b><tt>:dinodex</tt></b>::      Parses data in the dinodex format.
  # <b><tt>:african</tt></b>::      Parses data in the african format.
  #
  FORMATS = { dinodex: proc { |array| Dinosaur.new(array.to_hash) },
              african: proc do |array|
                hash = array.to_hash
                hash[:name] = hash[:genus]
                hash[:continent] = 'Africa'
                hash[:weight_in_lbs] = hash[:weight]
                hash[:diet] = array[:carnivore] == 'Yes' ? 'Carnivore' : 'Herbivore'

                Dinosaur.new(hash)
              end
  }

  class CSV
    #
    # Construct an array of dinosaurs from the given filename using the provided format.
    #
    # The format should be :dinodex or :african, as specified in FORMATS
    #
    def self.deserialize(filename, format = :dinodex)
      ::CSV.table(filename).map(&FORMATS[format])
    end
  end
end
