
class DinoDex
  attr_accessor :dinosaurs, :dino_names

  def initialize(joes_dinos, piratebay_dinos)
    dino_list = joes_dinos.concat(piratebay_dinos)
    @dinosaurs = dino_list.map { |dino| Dino.new(dino) }
    @dino_names = dino_list.map{ |dino| dino[:name] }
  end

  def all_dino_facts(dino_name)
    dino = @dinosaurs.select { |dino| dino.name.to_s == dino_name }.pop
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
    periods = %w( jurassic albian cretaceous triassic permian oxfordian )
    attributes = %w( fat small biped quadruped carnivore herbivore )
    collections = %w( joe pirate_bay )
    continents = %w( north_america south_america africa europe asia )

    case
    when periods.include?(filter) then filter_by_period(dinos, filter)
    when attributes.include?(filter) then filter_by_attribute(dinos, filter)
    when collections.include?(filter) then filter_by_collection(dinos, filter)
    when continents.include?(filter) then filter_by_continent(dinos, filter)
    end

  end

  def filter_by_attribute(dinos, filter)
    dinos.select! { |dino| dino.send("#{filter}?") }
  end

  def filter_by_period(dinos, filter)
    dinos.select! {|dino| dino.period.include? filter }
  end

  def filter_by_continent(dinos, filter)
    dinos.select! {|dino| dino.continent.include? filter.tr('_', ' ') }
  end

  def filter_by_collection(dinos, filter)
    if filter.eql? "pirate_bay" then filter_by_continent(dinos, "africa")
    else dinos.select! { |dino| dino.continent != "africa" }
    end
  end

end
