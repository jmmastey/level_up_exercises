require 'json'

class Dinosaur
  attr_reader :name, :period, :continent, :diet, :weight, :walking, :description
      
  def initialize(args={})
    @name        = args[:name]
    @period      = args[:period]
    @continent   = args[:continent]
    @diet        = args[:diet]
    @weight      = args[:weight].to_i if args[:weight]
    @walking     = args[:walking]
    @description = args[:description]
  end

  def to_s
    "Name: #{@name}, Period: #{@period}, Continent: #{@continent}, " +
    "Diet: #{@diet}, Weight: #{@weight}, Walking: #{@walking}, " +
    "Description: #{@description}"
  end

  def bigger?(lbs)
    @weight && @weight > lbs
  end 

  def smaller?(lbs)
    @weight && @weight < lbs
  end

  def carnivore?
    !herbivore?
  end

  def herbivore?
    @diet == "Herbivore"
  end

  def biped?
    @walking == "Biped"
  end

  def period?(per)
    !!(@period  =~ /#{per}/)
  end
  
  def facts  
    %w(Name Period Continent Diet Weight Walking Description)
    .inject("") do |acc, field|
      value = self.send(field.downcase.to_sym)
      acc += "#{field.ljust(15,'.')}#{value.to_s.rjust(25, '.')} \n" unless value.nil? 
    end 
  end
  
    def to_json
      %w(Name Period Continent Diet Weight Walking Description).each_with_object({}) do |f, acc|
      field = f.downcase.to_sym
      value = self.send(field)
      acc[field] = value if value 
    end
  end
end

class Dinodex
  
  @dinos=[]
  
  def initialize(initial_dinos)
    @dinos = initial_dinos
  end

  def add_dinos(new_dinos)
    @dinos = @dinos + new_dinos
  end

  def dinos
    @dinos
  end
  
  def dino_filter(field, criteria=nil)
    method = field.to_s.gsub(/s$/, '?').to_sym
    if criteria
      new_dinos = @dinos.select {|d| d.send(method, criteria) }
    else
      new_dinos = @dinos.select {|d| d.send(method) }
    end
    Dinodex.new(new_dinos) 
  end
  
  def dino_table
    print " " + "Name".ljust(20)
    print " " + "Period".ljust(18)
    print " " + "Continent".ljust(15) 
    print " " + "Diet".ljust(10)
    print " " + "Walking".ljust(10)
    print " " + "Weight".ljust(10) + "\n"
    puts "-" * 80
    @dinos.each do |d|
      line = " " + d.name.to_s.ljust(20)
      line << d.period.to_s.ljust(18)
      line << d.continent.to_s.ljust(15)
      line << d.diet.to_s.ljust(10)
      line << d.walking.to_s.ljust(10)
      line << d.weight.to_s.ljust(10)
      puts line
    end
  end
  
  def to_json(filename)
    File.open(filename,"w") do |f|
      @dinos.each do |d|
        f.puts d.to_json
      end
    end
  end
end  

class FileParser

  def self.parse_csv_file(filename)
    col_names = [ :name, :period, :continent, :diet, :weight, :walking, :description]
    File.readlines(filename).drop(1).each_with_object([]) do |line, dinos|
      dino_hash = make_hash(line, col_names)
      dinos << Dinosaur.new(dino_hash)
    end
  end

  def self.parse_tpb_file(filename)
    col_names = [ :name, :period, :carnivore, :weight, :walking]
    File.readlines(filename).drop(1).each_with_object([]) do |line, dinos|
      dino_hash = make_hash(line, col_names)
      dinos << Dinosaur.new(canonical_hash(dino_hash)) 
    end
  end

  def self.make_hash(line, col_names)
    Hash[col_names.zip(line.split(",").map { |x| x==""? nil: x})]
  end

  def self.canonical_hash(tpb_hash)
    if tpb_hash[:carnivore] == "Yes"
      tpb_hash[:diet] = "Carnivore"
      tpb_hash[:carnivore] = nil
    end
    tpb_hash[:continent] = "Africa"
    tpb_hash
  end
end


puts "Read csv file"
dinos = FileParser.parse_csv_file("dinodex.csv")
d = Dinodex.new(dinos)
puts "Reading tpb file"
tpb_dinos = FileParser.parse_tpb_file("african_dinosaur_export.csv")
d.add_dinos(tpb_dinos)
puts "-" * 30
puts "All dinos:"
puts "-" * 30
d.dino_table
puts "-" * 30
puts "Bipeds:"
puts "-" * 30
d.dino_filter(:bipeds).dino_table
puts "-" * 30
puts "Carnivores:"
puts "-" * 30
d.dino_filter(:carnivores).dino_table
puts "-" * 30
puts "Bigger than 2000 lbs:"
puts "-" * 30
d.dino_filter(:biggers, 2000).dino_table
puts "-" * 30
puts "From the Cretaceous period"
puts "-" * 30
d.dino_filter(:periods, "Cretaceous").dino_table
puts "-" * 30
puts "Chained call: carnivores smaller than 2500 lbs: "
puts "-" * 30
d.dino_filter(:carnivores).dino_filter(:smallers, 2500).dino_table
puts 
puts
puts "Info about a specific dino: "
puts "-" * 30
puts d.dinos[2].facts

puts "Exporting to json"
d.to_json("dinodex.json")
puts d.dinos[2].to_s
