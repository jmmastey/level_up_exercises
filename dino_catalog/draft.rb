require 'csv'

CSV::Converters[:blank_to_nil] = lambda do |field|
  field && field.empty? ? nil : field
end

$dinos = CSV.read("dinodex.csv", :headers => true, :header_converters => :symbol, :converters => :all)
$dinos = $dinos.map {|row| row.to_hash}

$african_dinos = CSV.read("african_dinosaur_export.csv", :headers => true, :header_converters => :symbol, :converters => :all)
$african_dinos = $african_dinos.map {|row| row.to_hash}

$african_dinos.each do |african_dino|
  african_dino[:name] = african_dino.delete :genus
  african_dino[:weight_in_lbs] = african_dino.delete :weight
  african_dino[:diet] = african_dino.delete :carnivore
  african_dino[:continent] = "Africa"
end

class Dino
  attr_accessor :name, :period, :continent, :diet, :weight_in_lbs, :walking, :description
  
  def initialize dino_hash
    dino_hash.each { |k,v| send("#{k}=", v) }
  end  
  
  def is_fat?
      @weight_in_lbs > 2000 && @weight_in_lbs != nil
  end
  
  def is_small?
    @weight_in_lbs <=2000 && @weight_in_lbs != nil
  end
  
  def is_biped?
    @walking.to_s.eql? "biped"
  end
  
  def is_carnivore?
    ["carnivore", "insectivore", "piscivore", "yes"].include? @diet.downcase
  end
  
end

class DinoDex
  attr_accessor :dinosaurs
  
  def initialize
    @dinosaurs = []
    $dinos.each {|dino| @dinosaurs << Dino.new(dino)}
    $african_dinos.each {|dino| @dinosaurs << Dino.new(dino)}
  end
  
  def all_facts dino
    dino.instance_variables.each do |dino_fact|
      if dino.instance_variable_get(dino_fact)
        puts dino_fact.to_s[1..-1].capitalize + ":"
        puts dino.instance_variable_get dino_fact
      end
    end
    puts "\n"
  end
  
end


dino_dex = DinoDex.new
dino_dex.all_facts(dino_dex.dinosaurs[15])
dino_dex.all_facts(dino_dex.dinosaurs[0])