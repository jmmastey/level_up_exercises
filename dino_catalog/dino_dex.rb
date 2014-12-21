
class DinoDex

attr_accessor :dinosaurs
  
  def initialize(dino_hash)
    @dinosaurs = dino_hash.map { |dino| Dino.new(dino) } 
  end
  
  def print_all_facts(dino_name)
    
    dino = @dinosaurs.select { |dino| dino.name.to_s.downcase == dino_name.downcase }.pop
    dino.to_s
    p dino.respond_to?("fat")

  end
  
  def filter_dinos(filters)
  
    filtered_dinos = @dinosaurs.dup
    period_filters = %w( jurassic albian cretaceous triassic permian oxfordian )
#    attribute_filters = %w( fat small biped quadruped carnivore herbivore )
#    collection_filters = %w( joe pirate_bay )
    
    filters.each do |filter|
      filtered_dinos.select! { |dino| dino.biped? } if filter == "biped"
      filtered_dinos.select! { |dino| dino.fat? } if filter == "fat"
      filtered_dinos.select! { |dino| dino.small? } if filter == "small"
      filtered_dinos.select! { |dino| dino.carnivore? } if filter == "carnivore"
      filtered_dinos.select! { |dino| dino.continent.downcase != "africa" } if filter == "joe"
      filtered_dinos.select! { |dino| dino.continent.downcase.eql? "africa" } if filter == "pirate_bay"      
      filter_by_period(filtered_dinos, filter) if period_filters.include? filter
    end
  filtered_dinos
  
  end
  
  def process_filter(dinos, filter)
    period_filters = %w( jurassic albian cretaceous triassic permian oxfordian )
    attribute_filters = %w( fat small biped quadruped carnivore herbivore )
    collection_filters = %w( joe pirate_bay )
    
  end
  
  def filter_by_attribute(dinos, filter)
    
  end
  
  def filter_by_period(dinos, filter)
    dinos.select! {|dino| dino.period.downcase.include? filter }   
  end
  
  def filter_by_continent(dinos, filter)
    dinos.select! {|dino| dino.continent.downcase.include? filter }   
  end
  
  def to_s
    @dinosaurs.map { |dino| dino.name.to_s }   
  end
  
end
