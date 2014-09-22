#INSTRUCTIONS: 
# easiest to run in irb and call parse_dino_csv, it returns a DinoDex colleciton object
# you can chain filter, each returning a DinDex collection object

require 'csv'

class Dino
  attr_accessor :name,:period,:continent,:diet,:weight,:walking,:description

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

  def print_attribs
    puts "Name: #{@name}" if @name && !@name.empty?
    puts "Period: #{@period}" if @period && !@period.empty?
    puts "Continent: #{@continent}" if @continent && !@continent.empty?
    puts "Diet: #{@diet}" if @diet && !@diet.empty?
    puts "Weight: #{@weight}" if @weight && !@weight.empty?
    puts "Walking: #{@walking}" if @walking && !@walking.empty?
    puts "Description: #{@description}" if @description && !@description.empty?
  end

  def write_json(filehandle)
    filehandle.write("  {" + "\n")
    ATTRIBUTES.each do |attrib|
      filehandle.write("    #{attrib}: #{send(attrib)}\n")
    end
    filehandle.write("  }" + "\n")
  end
end

class DinoDex
  attr_accessor :dinos

  def initialize(dinos)
    @dinos = dinos
  end

  def print_dinos
    @dinos.each { |dino| dino.print_attribs }
  end

  def write_json(filename='dino_json.txt')
    if File.exist? filename
      puts "file #{filename} already exists, pick another file name"
      return
    end

    f = File.open(filename,'a')
    f.write("[\n")
    @dinos.each do |dino|
      dino.write_json(f)
    end
    f.write("]")
    f.close
  end

  def bipeds
    filtered_dinos = @dinos.select do |dino|
      dino.walking ==  "Biped"
    end
    DinoDex.new(filtered_dinos)
  end

  def carnivores
    filtered_dinos = @dinos.select do |dino|
      %w[Carnivore Insectivore Piscivore].include? dino.diet
    end
    DinoDex.new(filtered_dinos)
  end

  %w[cretaceous permian jurassic oxfordian].each do |period|
    define_method(period) do
      filtered_dinos = @dinos.select do |dino|
        dino.period.downcase.include? period
      end
      DinoDex.new(filtered_dinos)
    end
  end

  def small
    filtered_dinos = @dinos.select do |dino|
      dino.weight.to_i <= 2000
    end
    DinoDex.new(filtered_dinos)
  end

  def big
    filtered_dinos = @dinos.select do |dino|
      dino.weight.to_i > 2000
    end
    DinoDex.new(filtered_dinos)
  end
end

def parse_dino_csv
  if !File.exist? "dinodex.csv"
    puts "cant find dinodex.csv file! exitting!"
    exit(1)
  end
  
  dinos = []
  CSV.foreach("dinodex.csv") do |row|
    next if row[0] == "NAME"
    dinos << Dino.new(name: row[0], period: row[1], continent: row[2], diet: row[3], weight: row[4], walking: row[5], description: row[6])
  end
  DinoDex.new(dinos)
end
