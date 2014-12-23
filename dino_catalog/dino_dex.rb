class DinoDex
  attr_reader :dinosaurs

  def initialize(joes_csv, pirate_bay_csv)
    dino_list = CSVtoDinos.csv_to_hash_array(joes_csv) + 
      CSVtoDinos.normalize(CSVtoDinos.csv_to_hash_array(pirate_bay_csv))
    @dinosaurs = dino_list.map { |dino| Dino.new(dino) }
    @dino_names = dino_list.map { |dino| dino[:name] }
  end

  def all_dino_facts(dino_name)
    dino = @dinosaurs.find { |dino| dino.name == dino_name }
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
      when periods.include?(filter) then period_filter(dinos, filter)
      when attributes.include?(filter) then attribute_filter(dinos, filter)
      when collections.include?(filter) then collection_filter(dinos, filter)
      when continents.include?(filter) then continent_filter(dinos, filter)
    end

  end

  def attribute_filter(dinos, filter)
    dinos.select! { |dino| dino.send("#{filter}?") }
  end

  def period_filter(dinos, filter)
    dinos.select! {|dino| dino.period.include? filter }
  end

  def continent_filter(dinos, filter)
    dinos.select! {|dino| dino.continent.include? filter.tr('_', ' ') }
  end

  def collection_filter(dinos, filter)
    if filter.eql? "pirate_bay" then filter_by_continent(dinos, "africa")
    else dinos.select! { |dino| dino.continent != "africa" }
    end
  end

end