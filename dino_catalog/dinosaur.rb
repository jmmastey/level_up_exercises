class Dinosaur
  attr_accessor :name, :period, :weight, :continent, :diet, :walking,
    :description, :trait, :dino_name

  CARNIVORE_DIET = %w(carnivore insectivore piscivore)
  DINO_TRAITS = %w(name period continent diet weight walking description size)

  def initialize(data)
    DINO_TRAITS.each do |trait|
      instance_variable_set("@#{trait}", "#{data[trait.to_sym]}")
    end
    @output = ''
  end

  def size
    big? ? 'Big' : 'Small'
  end

  def big?
    weight.to_i > 4000
  end

  def continent
    if @continent.nil? || @continent.empty?
      @continent = 'Africa'
    else
      @continent
    end
  end

  def diet
    if CARNIVORE_DIET.include? @diet.downcase
      @diet = 'Carnivore'
    else
      @diet = 'Herbivore'
    end
  end

  def to_s
    @output = "*" * 80
    DINO_TRAITS.each { |x| retrieve_trait(x) }
    @output
  end

  def retrieve_trait(dino_trait)
    value = send(dino_trait)
    @output << "\n#{dino_trait.capitalize}:  #{value}" unless blank? value
  end

  def blank?(str)
    str.nil? || str == '' || str == []
  end
end
