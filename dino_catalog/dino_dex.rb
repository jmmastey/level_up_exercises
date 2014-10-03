require_relative 'dinosaur'
require 'json'

# DinoDex is a container class that allows you to query for dinosaurs.
class DinoDex
  def initialize(dinosaurs = [])
    @dinosaurs = dinosaurs
  end

  def print
    puts @dinosaurs
  end

  def who(name)
    selection { | dino | dino.name == name }
  end

  def when(period)
    selection { | dino | dino.period == period }
  end

  def where(continent)
    selection { | dino | dino.continent == continent }
  end

  def diet(diet)
    selection { | dino | dino.diet == diet }
  end

  def carnivore
    selection do | dino |
      %w(Carnivore Insectivore Piscivore).include?(dino.diet)
    end
  end

  def weight(weight)
    selection { | dino | dino.weight == weight }
  end

  def big
    selection(&:big?)
  end

  def small
    selection(&:small?)
  end

  def walking(walking)
    selection { | dino | dino.walking == walking }
  end

  def search(parameters)
    temp = @dinosaurs.dup
    parameters.each do |(key, value)|
      temp = temp.select { | dino | dino.send(key) == value }
    end
    temp
  end

  def search(parameters)
    @dinosaurs.select do | dino |
      parameters.all? do | key, value |
        dino.send(key) == value
      end
    end
  end

  def to_json
    @dinosaurs.to_json
  end

  private

  def selection(&block)
    DinoDex.new(@dinosaurs.select(&block))
  end
end
