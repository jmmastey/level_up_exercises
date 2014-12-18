module CSVtoHash
  
  require 'csv'
  
  CSV::Converters[:blank_to_nil] = lambda do |field|
    field && field.empty? ? nil : field
  end

  def CSV_to_hash(file)
    @csv = CSV.read(file, :headers => true, :header_converters => :symbol, :converters => :all)
    @csv = @csv.map {|row| row.to_hash}
  end
    
#  dinos = CSV.read("dinodex.csv", :headers => true, :header_converters => :symbol, :converters => :all)
#  dinos = dinos.map {|row| row.to_hash}
#
#  african_dinos = CSV.read("african_dinosaur_export.csv", :headers => true, :header_converters => :symbol, :converters => :all)
#  african_dinos = african_dinos.map {|row| row.to_hash}

  def normalize_african_hash(dino_hash_array)
    dino_hash_array.each do |dino|
      dino[:name] = dino.delete :genus
      dino[:weight_in_lbs] = dino.delete :weight
      dino[:diet] = dino.delete :carnivore
      dino[:continent] = "Africa"
      if dino[:diet].eql? "Yes"
        dino[:diet] = "Carnivore"
      else
        dino[:diet] = "Herbivore"
      end
    end
  end

#  african_dinos.each do |african_dino|
#    african_dino[:name] = african_dino.delete :genus
#    african_dino[:weight_in_lbs] = african_dino.delete :weight
#    african_dino[:diet] = african_dino.delete :carnivore
#    african_dino[:continent] = "Africa"
#  end
end

include CSVtoHash

class Dino
  attr_accessor :name, :period, :continent, :diet, :weight_in_lbs, :walking, :description
  
  def initialize dino_hash
    dino_hash.each { |k,v| send("#{k}=", v) }
  end  
  
  def is_fat?
    @weight_in_lbs != nil && @weight_in_lbs > 2000
  end
  
  def is_small?
    @weight_in_lbs != nil && @weight_in_lbs <=2000
  end
  
  def is_biped?
    @walking.to_s.downcase.eql? "biped"
  end
  
  def is_carnivore?
    ["carnivore", "insectivore", "piscivore", "yes"].include? @diet.downcase
  end
  
end


class DinoDex

# attr_accessor :dinosaurs
  
  def initialize(dino_hash, african_dino_hash)
    @dinosaurs = []
    dino_hash.each {|dino| @dinosaurs << Dino.new(dino)}
    african_dino_hash.each {|dino| @dinosaurs << Dino.new(dino)}
  end
  
  def print_all_facts dino_name
    dino = @dinosaurs.select {|dino| dino.name.to_s.downcase == dino_name.downcase}
    dino[0].instance_variables.each do |dino_fact|
      if dino[0].instance_variable_get(dino_fact)
        puts dino_fact.to_s[1..-1].capitalize + ":\n" + dino[0].instance_variable_get(dino_fact).to_s
      end
    end
    puts "\n"
  end
  
  def filter_dinos(filter_array)
    @filtered_dinos = @dinosaurs
    #puts @filtered_dinos
    filter_array.each do |filter|
      
    if filter.to_s.downcase == "biped"
    @filtered_dinos.select! do |dino|
        dino.is_biped?
      end
    end
    
    if filter.to_s.downcase == "fat"
    @filtered_dinos.select! do |dino|
        dino.is_fat?
    end
  end
  
  if filter.to_s.downcase == "carnivore"
  @filtered_dinos.select! do |dino|
      dino.is_carnivore?
    end
  end
  
  if filter.to_s.downcase == "joe"
  @filtered_dinos.select! do |dino|
      dino.continent.downcase != "africa"
    end
  end
  
  if filter.to_s.downcase == "pirate_bay"
  @filtered_dinos.select! do |dino|
      dino.continent.downcase.eql? "africa"
    end
  end
  
    end
    @filtered_dinos.each {|dino| puts dino.name}
  end

  
  def all_dinos
    puts "All dinos:"
    @dinosaurs.each {|dino| puts dino.name}
  end
  
end



joes_dinos = CSV_to_hash("dinodex.csv")
#puts joes_dinos
piratebay_dinos = normalize_african_hash(CSV_to_hash("african_dinosaur_export.csv"))

puts piratebay_dinos

dino_dex = DinoDex.new(joes_dinos, piratebay_dinos)
dino_dex.print_all_facts("albertosaurus")
#dino_dex.print_all_facts("afrovenator")
#dino_dex.all_dinos
#dino_dex.print_all_facts("suchomimus")
#puts dino_dex.dinosaurs[3].is_fat?
#puts dino_dex.dinosaurs[3].is_small?
#p dino_dex.dinosaurs[3].weight_in_lbs
puts "Enter options:"
user_input = []
user_input << gets.chomp
p user_input
if user_input.include? "afrovenator"
  puts dino_dex.print_all_facts(user_input[0])
end

#dino_dex.filter_dinos(["joe", "fat", "africa"])