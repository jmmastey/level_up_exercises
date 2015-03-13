require './dino'

class DinoCatalog
  include Enumerable
  extend Forwardable

  def_delegators :@dino_catalog, :each, :<<
  attr_reader :dino_catalog

  def initialize(catalog = [])
    @dino_catalog = catalog
  end

  def add(dino)
    dino_catalog << dino
  end

  def self.print(dino_catalog)
    dino_catalog.each(&:print)
  end

  def empty?
    @dino_catalog.empty?
  end

  def bipeds
    DinoCatalog.new(@dino_catalog.select { |dino| dino.walking.downcase == 'biped' })
  end

  def carnivores
    valid_carnivores = ['carnivore', 'piscivore', 'insectivore']
    DinoCatalog.new(@dino_catalog.select { |dino| valid_carnivores.include? dino.diet.downcase })
  end

  def by_period(period)
    DinoCatalog.new(@dino_catalog.select { |dino| dino.period.downcase.include? period })
  end

  def small
    DinoCatalog.new(@dino_catalog.select { |dino| dino.weight.to_i < 4001 })
  end

  def big
    DinoCatalog.new(@dino_catalog.select { |dino| dino.weight.to_i > 4000 })
  end

  def find_by_name(name)
    DinoCatalog.new(@dino_catalog.select { |dino| dino.name.downcase.include? name })
  end
end
