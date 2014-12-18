module CSVtoHashTools
  
  require 'csv'
  
  CSV::Converters[:blank_to_nil] = lambda do |field|
    field && field.empty? ? nil : field
  end

  def CSV_to_hash(file)
    @csv = CSV.read(file, :headers => true, :header_converters => :symbol, :converters => :all)
    @csv = @csv.map {|row| row.to_hash}
  end

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
end

include CSVtoHashTools

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
    ["carnivore", "insectivore", "piscivore"].include? @diet.downcase
  end
  
end


class DinoDex

attr_accessor :dinosaurs
  
  def initialize(dino_hash)
    @dinosaurs = []
    dino_hash.each {|dino| @dinosaurs << Dino.new(dino)}
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
  
    if filter.to_s.downcase == "small"
      @filtered_dinos.select! do |dino|
        dino.is_small?
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
  
    if filter.to_s.downcase == "jurassic"
      @filtered_dinos.select! do |dino|
        dino.continent.downcase.eql? "jurassic"
      end
    end
  
    if filter.to_s.downcase == "albian"
      @filtered_dinos.select! do |dino|
        dino.continent.downcase.eql? "albian"
      end
    end
  
    if filter.to_s.downcase == "cretacious"
      @filtered_dinos.select! do |dino|
        dino.continent.downcase.eql? "cretacious" || "late cretacious" || "early cretacious"
      end
    end
  
    if filter.to_s.downcase == "triassic"
      @filtered_dinos.select! do |dino|
        dino.continent.downcase.eql? "triassic"
      end
    end
  
    if filter.to_s.downcase == "permian"
      @filtered_dinos.select! do |dino|
        dino.continent.downcase.eql? "permian" || "late permian" || "early permian"
      end
    end
  
    if filter.to_s.downcase == "oxfordian"
      @filtered_dinos.select! do |dino|
        dino.continent.downcase.eql? "oxfordian"
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
piratebay_dinos = normalize_african_hash(CSV_to_hash("african_dinosaur_export.csv"))
merged_dinos = joes_dinos.concat(piratebay_dinos)

$dino_names_array = merged_dinos.map{ |dino_hash| dino_hash[:name].downcase }


$dino_dex = DinoDex.new(merged_dinos)

$dino_dex.print_all_facts("albertosaurus")
#dino_dex.print_all_facts("afrovenator")
#dino_dex.all_dinos
#dino_dex.print_all_facts("suchomimus")
#puts dino_dex.dinosaurs[3].is_fat?
#puts dino_dex.dinosaurs[3].is_small?
#p dino_dex.dinosaurs[3].weight_in_lbs

module DinoDexCommandLine
  
  def get_and_check_input
    puts "Enter options (type \"help\" for list of commands): \n"
    @user_input = []
    @user_input = gets.chomp.strip.split

    if @user_input == []
      puts "Invalid command.  Please try again."
      get_and_check_input
    end
    
    if @user_input.length == 1
      if @user_input[0].eql? "help"
        puts "heres help menu heh"
        get_and_check_input
      elsif @user_input[0].downcase.eql? "all_dinos"
        puts "\nLIST OF ALL DINOS:"
        $dino_dex.all_dinos
        puts "\n"
        get_and_check_input
      elsif $dino_names_array.include? @user_input[0].downcase
        puts "\n"
        $dino_dex.print_all_facts(@user_input[0])
        puts "\n"
        get_and_check_input
      elsif @user_input[0].downcase.eql? "exit"
        return
      else
        puts "Invalid command.  Please try again."
        get_and_check_input
      end
    end
    
    if @user_input.length > 1
      if @user_input[0].downcase != "filter"
        puts "Invalid command.  Please try again."
        get_and_check_input
      else
        if @user_input[1..-1].uniq.length == @user_input[1..-1].length
          
#        else
 #         puts "Invalid command.  Please try again."
  #        get_and_check_input
        end
        
        #big OR small, bipeds, carnivores, period, collection
        
        
      end
    end
    
    
  end
end
  


include DinoDexCommandLine

get_and_check_input


#dino_dex.filter_dinos(["joe", "fat", "africa"])