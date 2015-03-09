require 'CSV'

class DinoCatalog
  include Enumerable
  extend Forwardable

  def_delegators :@dino_catalog, :each, :<<
  attr_reader :dino_catalog

  def initialize(catalog = [])
    @dino_catalog = catalog

    if @dino_catalog.empty?
      add_default_csv
      add_african_csv
    end
  end

  def add(dino)
    dino_catalog << dino
  end

  def add_default_csv
    @dinos = CSV.read('dinodex.csv',
                      headers: true,
                      header_converters: :symbol)

    @dinos.each do |dino|
      restructured_dino = {
        name: dino[:name],
        period: dino[:period],
        continent: dino[:continent],
        diet: dino[:diet],
        weight: dino[:weight_in_lbs],
        walking: dino[:walking],
        description: dino[:description]
      }

      add Dino.new(restructured_dino)
    end
  end

  def add_african_csv
    @dinos = CSV.read('african_dinosaur_export.csv',
                      headers: true,
                      header_converters: :symbol)

    @dinos.each do |dino|
      restructured_dino = {
        name: dino[:genus],
        period: dino[:period],
        continent: 'Africa',
        diet: dino[:carnivore].downcase == 'yes' ? 'Carnivore' : 'Herbivore',
        weight: dino[:weight],
        walking: dino[:walking],
        description: dino[:description]
      }

      add Dino.new(restructured_dino)
    end
  end

  def self.print(dino_catalog)
    dino_catalog.each { |dino| dino.print }
  end

  def &(rvalue)
    DinoCatalog.new(@dino_catalog & rvalue.dino_catalog)
  end

  def empty?
    @dino_catalog.empty?
  end

  def get_bipeds
    @dino_catalog.select { |dino| dino.walking.downcase == 'biped' }
  end

  def get_carnivores
    valid_carnivores = ['carnivore', 'piscivore', 'insectivore']
    @dino_catalog.select { |dino| valid_carnivores.include? dino.diet.downcase }
  end

  def get_by_period(period)
    @dino_catalog.select { |dino| dino.period.downcase.include? period }
  end

  def get_small
    @dino_catalog.select { |dino| dino.weight.to_i < 4001 }
  end

  def get_big
    @dino_catalog.select { |dino| dino.weight.to_i > 4000 }
  end

  def get_by_name(name)
    @dino_catalog.select { |dino| dino.name.downcase.include? name}
  end
end
