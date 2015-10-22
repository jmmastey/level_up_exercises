require 'csv'
require_relative 'dinosaur'

class DinosaurCsvDeserializer
  DINODEX_CSV_DESERIALIZER = proc { |array| Dinosaur.new(array.to_hash) }

  AFRICAN_CSV_DESERIALIZER = proc do |array|
    hash = array.to_hash
    hash[:name] = hash[:genus]
    hash[:continent] = 'Africa'
    hash[:weight_in_lbs] = hash[:weight]
    hash[:diet] = array[:carnivore] == 'Yes' ? 'Carnivore' : 'Herbivore'

    Dinosaur.new(hash)
  end

  class << self
    def deserialize(filename, &block)
      CSV.table(filename).map(&block)
    end
  end
end
