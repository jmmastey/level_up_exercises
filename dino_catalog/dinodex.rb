require 'json'
require 'table_print'
autoload? 'formatter.rb'

# Class Dinodex will have dino collection and search api
class Dinodex
  attr_accessor :dinos

  def initialize(*filepaths)
    @dinos = []
    filepaths.each do |fp|
      @dinos += Formatter.format(fp)
    end
  end

  def search_by_walking(walking)
    @dinos = @dinos.select { |dino| dino.walking == walking }
    self
  end

  def search_by_name(name)
    @dinos = @dinos.select { |dino| dino.name == name }
    self
  end

  def search_by_source(source)
    @dinos = @dinos.select { |dino| dino.source == source }
    self
  end

  def search_by_diet(diet)
    @dinos = @dinos.select { |dino| dino.diet == diet }
    self
  end

  def search_carnivores
    @dinos = @dinos.select(&:carnivore?)
    self
  end

  def search_by_period(period)
    @dinos = @dinos.select { |dino| dino.period_within?(period) }
    self
  end

  def search_big
    @dinos = @dinos.select(&:big?)
    self
  end

  def search_small
    @dinos = @dinos.select(&:small?)
    self
  end

  def print
    tp dinos, :name, :period, :diet, :weight,
       :walking, :continent, :description, :source
  end

  def print_json
    puts @dinos.to_json
  end
end
