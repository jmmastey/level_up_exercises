class Dinodex
  attr_accessor :dinos

  def initialize(dinos)
    @dinos = dinos
  end

  def find_by(header, value)
    dinodex = Dinodex.new(@dinos)
    case header
      when :weight
        dinodex.dinos = search_by_weight(value, dinodex)
      when :diet
        dinodex.dinos = search_by_diet(value, dinodex)
      else
        dinodex.dinos = search_by_criteria(header, value, dinodex)
    end
    dinodex
  end

  def search_by_weight(size, dinodex)
    if size == 'big'
      dinodex.dinos.select(&:big?)
    else
      dinodex.dinos.select(&:small?)
    end
  end

  def search_by_diet(value, dinodex)
    if value == 'carnivore'
      dinodex.dinos.select(&:carnivore?)
    else
      search_by_criteria(:diet, value, dinodex)
    end
  end

  def search_by_criteria(header, value, dinodex)
    dinodex.dinos.select do |dino|
      dino.send(header).downcase.include? value
    end
  end

  def to_s
    @dinos.each do |dino|
      puts dino
    end
  end
end
