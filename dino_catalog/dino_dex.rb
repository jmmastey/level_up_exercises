
class DinoDex

attr_accessor :dinosaurs
  
  def initialize(dino_hash)
    
    @dinosaurs = []
    dino_hash.each { |dino| @dinosaurs << Dino.new(dino) }
    
  end
  
  def print_all_facts(dino_name)
    @dino_facts = []
    dino = @dinosaurs.select { |dino| dino.name.to_s.downcase == dino_name.downcase }
    
    dino[0].instance_variables.map do |dino_fact|
      if dino[0].instance_variable_get(dino_fact)
        @dino_facts << dino_fact.to_s[1..-1].capitalize
        @dino_facts << dino[0].instance_variable_get(dino_fact).to_s
      end
    end
    @dino_facts
  end
  
  def filter_dinos(filters)
    #remove array from variable name
    
    @filtered_dinos = @dinosaurs.dup
    
    filters.each do |filter|
       
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
          dino.period.downcase.include? "jurassic"
        end
      end
  
      if filter.to_s.downcase == "albian"
        @filtered_dinos.select! do |dino|
          dino.period.downcase.include? "albian"
        end
      end
  
      if filter.to_s.downcase == "cretaceous"
        @filtered_dinos.select! do |dino|
          dino.period.downcase.include? "cretaceous"
        end
      end
  
      if filter.to_s.downcase == "triassic"
        @filtered_dinos.select! do |dino|
          dino.period.downcase.include? "triassic"
        end
      end
  
      if filter.to_s.downcase == "permian"
        @filtered_dinos.select! do |dino|
          dino.period.downcase.include? "permian"
        end
      end
  
      if filter.to_s.downcase == "oxfordian"
        @filtered_dinos.select! do |dino|
          dino.period.downcase.include? "oxfordian"
        end
      end
    end
  @filtered_dinos.each { |dino| puts dino.name }
  end
  
  def all_dinos
    
    puts "All dinos:"
    @dinosaurs.map { |dino| dino.name.to_s }
    
  end
  
end
