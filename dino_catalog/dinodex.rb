require './dino'
require './dino_csv_parser'

class DinoDex
  attr_accessor :dinos

  def initialize(dinos = [])
    @dinos = dinos
  end

  def add_dinos_from_csv(filename = 'dinodex.csv')
    add_dinos(DinoCsvParser.parse_dinos_from_csv(filename)) 
  end

  def add_dinos(dinos)
    if !dinos.is_a?(Array)
      raise ArgumentError, "Not an array"
    end

    if !dinos.all? { |dino| dino.is_a?(Dino) }
      raise ArgumentError, "array contains non Dinos"
    end
      
    @dinos.concat dinos
  end

  %w[triassic cretaceous permian jurassic oxfordian].each do |period|
    define_method(period) do
      DinoDex.new(@dinos.select { |dino| dino.lived_during?(period) })
    end
  end

  def bipeds
    DinoDex.new @dinos.select(&:biped?)
  end

  def carnivores
    DinoDex.new @dinos.select(&:carnivore?)
  end

  def small
    DinoDex.new @dinos.select(&:small?)
  end

  def big
    DinoDex.new @dinos.select(&:big?)
  end

  def to_s(delimiter = "\n")
    @dinos.map(&:to_s).join(delimiter)
  end

  def to_json
    @dinos.map(&:to_hash).to_json
  end

  def write_json_to_file(filename = 'dino_json.txt', overwrite = false)
    if File.exist?(filename) && !overwrite
      raise ArgumentError, "file name already exists"
    end

    f = File.open(filename, 'w')
    f.write(to_json)
    f.close
  end
end
