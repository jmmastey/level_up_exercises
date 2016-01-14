require './import'
require './filter_dinos'
require 'pp'

DINO_ATTRIBUTES = [:name, :period, :continent, :diet, :weight, :walking,
                   :description]

class DinoCollection
  attr_accessor :collection_of_dinos

  def initialize(load = false)
    @collection_of_dinos = []
    load_from_csv_files if load
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
    many_dino_objects.each { |dino| add_dino(dino)}
  end

  def fancy_display
    @collection_of_dinos.each do |dino|
      DINO_ATTRIBUTES.each do |attribute|
        
      end
    end
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

  def carnivore?
    return false if @diet=="Herbivore"
    true
  end
end

main_collection = DinoCollection.new(true)

main_collection.fancy_display
#bipeds = DinoFilter.filter_by_category_value(main_collection, "walking", "Biped")
#puts bipeds.inspect

#carnivore = DinoFilter.filter_by_category_value(main_collection, "diet", "true")
