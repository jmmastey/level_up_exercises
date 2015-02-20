require 'json'

class Dinosaur

  attr_reader :name, :period, :diet, :weight, :movement, :continent,
    :description

  def initialize(dino)
    @name = dino.fetch(:name)
    @diet = dino[:diet]
    @weight = dino[:weight]
    @movement = dino[:movement]
    @continent = dino[:continent]
    @description = dino[:description]
    @period = dino[:period]
  end

  def to_h
    {name: @name,
     period: period_to_string.to_s,
     diet: @diet,
     weight: @weight,
     movement: @movement,
     continent: @continent,
     description: @description}.to_json
  end

  def period_to_string
    @per = ""
    @period.each do |val|
      @per += val
    end
  end
end

