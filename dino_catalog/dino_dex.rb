require_relative "dinosaur"
require "json"

class DinoDex

  def initialize(dinosaurs = [])
    @dinosaurs = dinosaurs
  end

  def print 
    puts @dinosaurs
  end

  def who(name)
    selection {|dino| dino.name == name}
  end

  def when(period) 
    selection {|dino| dino.period == period}
  end

  def where(continent)
    selection {|dino| dino.continent == continent}
  end

  def diet(diet)
    selection {|dino| dino.diet == diet}
  end

  def carnivore
    selection {|dino| ["Carnivore", "Insectivore", "Piscivore"].include?(dino.diet)} 
  end

  def weight(weight)
    selection {|dino| dino.weight == weight?}
  end

  def big
    selection {|dino| dino.big?}
  end

  def small
    selection {|dino| !dino.big?}
  end

  def walking(walking)
    selection {|dino| dino.walking == walking}
  end

  def search(parameters)
    temp = @dinosaurs.dup
    parameters.each do |(key,value)|
      temp = temp.select {|dino| dino.send(key) == value}
    end
    temp
  end

  def to_json
    @dinosaurs.to_json
  end

  private

  def selection(&block)
    DinoDex.new(@dinosaurs.select(&block))
  end

end
