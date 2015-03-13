require './dino'

class DinoCatalog
  attr_reader :dino_catalog

  def initialize(catalog = [])
    @dino_catalog = catalog
  end

  def add(dino)
    @dino_catalog << dino
  end

  def print
    @dino_catalog.each(&:print)
  end

  def empty?
    @dino_catalog.empty?
  end

  def filter(attribute, value = nil)
    if value.nil?
      method = attribute
      public_send(method) if respond_to?(method)
    else
      method = "find_by_#{attribute}"
      self.public_send(method, value) if self.respond_to? method
    end
  end

  def bipeds
    DinoCatalog.new(@dino_catalog.select { |dino| dino.walking.downcase == 'biped' })
  end

  def carnivores
    valid_carnivores = ['carnivore', 'piscivore', 'insectivore']
    DinoCatalog.new(@dino_catalog.select { |dino| valid_carnivores.include? dino.diet.downcase })
  end

  def small
    DinoCatalog.new(@dino_catalog.select { |dino| dino.weight.to_i < 4001 })
  end

  def big
    DinoCatalog.new(@dino_catalog.select { |dino| dino.weight.to_i > 4000 })
  end

  def find_by_period(period)
    DinoCatalog.new(@dino_catalog.select { |dino| dino.period.downcase.include? period })
  end

  def find_by_name(name)
    DinoCatalog.new(@dino_catalog.select { |dino| dino.name.downcase.include? name })
  end
end
