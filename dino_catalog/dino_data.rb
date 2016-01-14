DINO_ATTRIBUTES = [:name, :period, :continent, :diet, :weight, :walking,
                   :description]

class DinoCollection
  attr_accessor :collection_of_dinos

  def initialize(load_from_csv = false)
    @collection_of_dinos = []
    load_from_csv_files if load_from_csv
  end

  def load_from_csv_files
    data_to_load = ImportData.load_and_transform
    data_to_load.each { |attrs| create_dino(attrs) }
  end

  def create_dino(attrs)
    @collection_of_dinos << Dino.new(attrs)
  end

  def add_dino(dino)
    @collection_of_dinos << dino
  end

  def add_many_dinos(many_dino_objects)
    many_dino_objects.each { |dino| add_dino(dino) }
  end

  def fancy_display
    @collection_of_dinos.each(&:fancy_display)
  end

  def create_hash_from_dinos
    array_of_hashes = []
    @collection_of_dinos.each do |dino|
      array_of_hashes << dino.hash_of_attributes
    end
    array_of_hashes
  end
end

class Dino
  attr_reader :name
  attr_reader :period
  attr_reader :continent
  attr_reader :diet
  attr_reader :weight
  attr_reader :walking
  attr_reader :description

  def initialize(attrs)
    @name = attrs[:name]
    @period = attrs[:period]
    @continent = attrs[:continent]
    @diet = attrs[:diet]
    @weight = attrs[:weight]
    @walking = attrs[:walking]
    @description = attrs[:description]
  end

  def carnivore_or_herbivore
    return "Herbivore" if @diet == "Herbivore"
    "Carnivore"
  end

  def fancy_display
    puts
    DINO_ATTRIBUTES.each do |attribute|
      next if send(attribute).nil?
      puts "#{attribute}...#{send(attribute)}"
    end
  end

  def hash_of_attributes
    attribute_hash = {}
    DINO_ATTRIBUTES.each do |attribute|
      next if send(attribute).nil?
      attribute_hash[attribute] = send(attribute)
    end
    attribute_hash
  end
end
