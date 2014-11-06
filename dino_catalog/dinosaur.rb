class Dinosaur
  LARGE_DINOSAUR_MIN_WEIGHT  = 4000
  CARNIVORE  = %w(carnivore insectivore piscivore)
  ATTRS = [:name, :period, :continent, :diet, :weight, :walking, :description]

  attr_reader(*ATTRS)

  def initialize(params = {})
    ATTRS.each do |attr|
      instance_variable_set("@#{attr}", params[attr])
    end
  end

  def biped?
    return false if @walking.nil?
    @walking.downcase == "biped"
  end

  def quadruped?
    !biped?
  end

  def carnivore?
    return false if @diet.nil?
    CARNIVORE.include?(@diet.downcase)
  end

  def herbivore?
    !carnivore?
  end

  def large?
    return false if @weight.nil?
    @weight > LARGE_DINOSAUR_MIN_WEIGHT
  end

  def small?
    !large?
  end

  def period?(period)
    @period =~ /$#{period}/i
  end

  def continent?(continent)
    p continent
    @continent =~ /$#{continent}/i
  end

  def display
    ATTRS.each do |attr|
      value = send(attr)
      puts format("%-15s: %s", attr.to_s.capitalize, value) unless value.nil?
    end

    puts '-' * 80
  end

  def to_hash
    ATTRS.each_with_object({}) do |key, hash|
      hash[key] = send(attr) || ""
    end
  end
end
