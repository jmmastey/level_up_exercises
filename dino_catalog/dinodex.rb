require 'json'

class Dinosaur
  attr_reader :name, :period, :continent, :diet, :weight, :walking, :description
      
  def initialize(args={})
    @name        = args[:name]
    @period      = args[:period]
    @continent   = args[:continent]
    @diet        = args[:diet]
    @weight      = args[:weight].nil? ? nil : args[:weight].to_i
    @walking     = args[:walking]
    @description = args[:description]
  end

  def to_s
    "#{@name}, #{@period}, #{@continent}, #{@diet}, #{@weight}, #{@walking}"
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
    !(@period  =~ Regexp.new(per)).nil?
  end
  
  def print_facts
    facts = ""
    ["Name", "Period", "Continent", "Diet", "Weight", "Walking", "Description"].each do |field|
      value = self.send(field.downcase.to_sym)
      facts += "#{field.ljust(15,'.')}#{value.to_s.rjust(25, '.')} \n" unless value.nil? 
    end
    facts += "-" * 20
    puts facts
  end
  
    def to_json
    obj = {}
    ["Name", "Period", "Continent", "Diet", "Weight", "Walking", "Description"].each do |field|
      value = self.send(field.downcase.to_sym)
      obj[field] = value if value 
    end
    obj.to_json
  end

end

class Dinodex
  
  @dinos=[]
  
  def self.parse_file(filename)
    dinos = []
    File.readlines(filename).drop(1).each do |line|
      dinos << Dinosaur.new(convert_line(line.chomp))
    end
    dinos 
  end
  
  def self.convert_line(line)
    # convert line to canonical hash
    col_names = [:name, :period, :continent, :diet, :weight, :walking, :description]
    Hash[col_names.zip(line.split(",").map { |x| x==""? nil: x})]
  end


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
    print " " + "Name".ljust(15)
    print " " + "Period".ljust(18)
    print " " + "Continent".ljust(15) 
    print " " + "Diet".ljust(10)
    print " " + "Walking".ljust(10)
    print " " + "Weight".ljust(10) + "\n"
    puts "-" * 80
    @dinos.each do |d|
      line = " " + d.name.to_s.ljust(15)
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



dinos = Dinodex.parse_file("dinodex.csv")
d = Dinodex.new(dinos)
d.dino_table
d.dinos[1].print_facts
puts "Bipeds:"
d.dino_filter(:bipeds).dino_table

puts "carnivores:"
d.dino_filter(:carnivores).dino_table

puts "Bigger than 2000 lbs:"
d.dino_filter(:biggers, 2000).dino_table

puts "From the Cretaceous period"
d.dino_filter(:periods, "Cretaceous").dino_table

puts "Chained call: carnivores smaller than 2500 lbs: "
d.dino_filter(:carnivores).dino_filter(:smallers, 2500).dino_table
puts 
puts
puts "Info about a specific dino: "
d.dinos[2].print_facts

puts "Exporting to json"
d.to_json("dinodex.json")
