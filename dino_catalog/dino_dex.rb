
class DinoDex

attr_accessor :dinosaurs
  
  def initialize(dino_hash)
    
    @dinosaurs = []
    dino_hash.each { |dino| @dinosaurs << Dino.new(dino) }
    
  end
  
  def print_all_facts(dino_name)
    @dino_facts = []
    dino = @dinosaurs.select { |dino| dino.name.to_s.downcase == dino_name.downcase }
    
    puts "Name: #{dino[0].name}"
    puts "Period: #{dino[0].period}" if dino[0].period
    puts "Continent: #{dino[0].continent}" if dino[0].continent  
    puts "Diet: #{dino[0].diet}" if dino[0].diet
    puts "Weight (lbs): #{dino[0].weight_in_lbs}" if dino[0].weight_in_lbs
    puts "Walking: #{dino[0].walking}" if dino[0].walking
    puts "Description: #{dino[0].description}" if dino[0].description

  end
  
  def filter_dinos(filters)
    
    @filtered_dinos = @dinosaurs.dup
    @filterss = %w( biped fat small carnivore joe pirate_bay jurassic albian cretaceous triassic permian oxfordian )
    filters.each do |filter|
      @filtered_dinos.select! { |dino| dino.is_biped? } if filter == "biped"
      @filtered_dinos.select! { |dino| dino.is_fat? } if filter == "fat"
      @filtered_dinos.select! { |dino| dino.is_small? } if filter == "small"
      @filtered_dinos.select! { |dino| dino.is_carnivore? } if filter == "carnivore"
      @filtered_dinos.select! { |dino| dino.continent.downcase != "africa" } if filter == "joe"
      @filtered_dinos.select! { |dino| dino.continent.downcase.eql? "africa" } if filter == "pirate_bay"
      @filtered_dinos.select! { |dino| dino.period.downcase.include? "jurassic" } if filter == "jurassic"
      @filtered_dinos.select! { |dino| dino.period.downcase.include? "albian" } if filter == "albian"
      @filtered_dinos.select! { |dino| dino.period.downcase.include? "cretaceous" } if filter == "cretaceous"
      @filtered_dinos.select! { |dino| dino.period.downcase.include? "triassic" } if filter == "triassic"
      @filtered_dinos.select! { |dino| dino.period.downcase.include? "permian" } if filter == "permian"
      @filtered_dinos.select! { |dino| dino.period.downcase.include? "oxfordian" } if filter == "oxfordian"
    end
  @filtered_dinos.each { |dino| puts dino.name }
  end
  
  def biped_filter(dinos)
  end
  
  def all_dinos
    
    puts "All dinos:"
    @dinosaurs.map { |dino| dino.name.to_s }
    
  end
  
end
