class Dinodex
  attr_accessor :dinos, :dinodex

  def initialize(dinos)
    @dinos = dinos
  end

  def search_by_criteria(header, value)
    @dinodex = Dinodex.new(@dinos)
    case header
      when :diet
        dinodex.dinos = search_by_diet(value)
      else
        dinodex.dinos = dinodex.dinos.select do |dino|
          dino.send(header).downcase.include? value
        end
    end
    dinodex
  end

  def search_by_weight(size)
    dinodex = Dinodex.new(@dinos)
    if size == 'big'
      dinodex.dinos.select(&:big?)
    else
      dinodex.dinos.select(&:small?)
    end
  end

  def search_by_diet(value)
    dinodex = Dinodex.new(@dinos)
    if value == 'carnivore'
      dinodex.dinos.select(&:carnivore?)
    else
      dinodex.dinos.select do |dino|
        dino.send(:diet).downcase.include? value
      end
    end
  end

  def to_s
    @dinos.each do |dino|
      puts dino
    end
  end
end
