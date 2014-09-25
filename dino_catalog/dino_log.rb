#INSTRUCTIONS: 
# easiest to run in irb and call parse_dino_csv, 
# it returns a DinoDex colleciton object
# you can chain filter, each returning a DinDex collection object

require 'csv'
require 'json'
require 'pry'

class Dino
  attr_accessor :name, :period, :continent, :diet, :weight, :walking, :description

  ATTRIBUTES = %w[name period continent diet weight walking description]

  def initialize(opts)
    @name = opts[:name]
    @period = opts[:period]
    @continent = opts[:continent]
    @diet = opts[:diet]
    @weight = opts[:weight]
    @walking = opts[:walking]
    @description = opts[:description]
  end

  def attrs_to_hash
    ATTRIBUTES.inject({}) { |result, att| result[att] = send(att).to_s; result }
  end

  def print_attribs
    ATTRIBUTES.inject("") { |result, att| result = result + attr_to_s(att) + ", " }
  end

  def small?
    @weight.to_i <= 2000 
  end

  def big?
    !small?
  end

  def biped?
    @walking == "Biped"
  end

  def carnivore?
    %w[Carnivore Insectivore Piscivore].include? @diet
  end

  private

  def attr_to_s(attrib_name)
    attr_value = send(attrib_name).to_s
    attr_value ? "#{attrib_name}: #{attr_value}" : ""
  end

end

class DinoDex
  attr_accessor :dinos

  def initialize(dinos)
    @dinos = dinos
  end

  def print_dinos
    @dinos.map { |dino| dino.print_attribs }
  end

  def write_json_to_file(filename='dino_json.txt', overwrite=false)
    raise ArgumentError, "file name already exists" if File.exist?(filename) && !overwrite

    f = File.open(filename,'w')
    f.write(dinos_to_array.to_json)
    f.close
  end

  def dinos_to_array
    @dinos.inject([]) { |result,dino| result << dino.attrs_to_hash; result }
  end

  %w[cretaceous permian jurassic oxfordian].each do |period|
    define_method(period) do
      filtered_dinos = @dinos.select { |dino| dino.period.downcase.include? period }
      DinoDex.new(filtered_dinos)
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
end

def parse_dino_csv(filename='dinodex.csv')
  raise ArgumentError, "couldnt find #{filename}" if !File.exist?(filename)
 
  dinos = []
  CSV.foreach(filename, headers: true) do |row|

    name =        row['Genus']        || row['NAME']
    period =      row['Period']       || row['PERIOD']
    continent =   row['Continent']    || row['CONTINENT']
    diet =        row['DIET']         || set_custom_diet(row['Carnivore'])
    weight =      row['Weight']       || row['WEIGHT_IN_LBS']
    walking =     row['Walking']      || row['WALKING']
    description = row['DESCRIPTION']

    dinos << Dino.new(name: name, 
                      period: period, 
                      continent: continent, 
                      diet: diet, 
                      weight: weight,   
                      walking: walking, 
                      description: description)
  end
  DinoDex.new(dinos)
end

def set_custom_diet(is_carnivore)
  if is_carnivore == "Yes" 
    "Carnivore"
  elsif is_carnivore == "No"
    "Non-carnivore"
  else
    "Unknown"
  end
end
