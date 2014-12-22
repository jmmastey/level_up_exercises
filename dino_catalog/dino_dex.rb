
class DinoDex

attr_accessor :dinosaurs
  
  def initialize(dino_hash)
    @dinosaurs = dino_hash.map { |dino| Dino.new(dino) } 
  end
  
  def print_all_facts(dino_name)  
    dino = @dinosaurs.select { |dino| dino.name.to_s.downcase == dino_name.downcase }.pop
    dino.to_s
  end
  
  def filter_dinos(filters)
    filtered_dinos = @dinosaurs.dup
    filters.each { |filter| process_filter(filtered_dinos, filter) } 
    filtered_dinos
  end
  
  def to_s
    @dinosaurs.map { |dino| dino.name }   
  end
  
  private
  
  def process_filter(dinos, filter)
    period_filters = %w( jurassic albian cretaceous triassic permian oxfordian )
    attribute_filters = %w( fat small biped quadruped carnivore herbivore )
    collection_filters = %w( joe pirate_bay )
    continent_filters = %w( north south africa europe asia )
    
    case
    when period_filters.include?(filter) then filter_by_period(dinos, filter)
    when attribute_filters.include?(filter) then filter_by_attribute(dinos, filter)
    when collection_filters.include?(filter) then filter_by_collection(dinos, filter)
    when continent_filters.include?(filter) then filter_by_continent(dinos, filter)
    end
    
  end
  
  def filter_by_attribute(dinos, filter)
    dinos.select! { |dino| dino.send("#{filter}?") }
  end
  
  def filter_by_period(dinos, filter)
    dinos.select! {|dino| dino.period.downcase.include? filter }   
  end
  
  def filter_by_continent(dinos, filter)
    dinos.select! {|dino| dino.continent.downcase.include? filter }   
  end
  
end
