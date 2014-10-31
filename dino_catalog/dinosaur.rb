class Dinosaur
  BIPED                  = "Biped"
  QUADRUPED              = "Quadruped"
  BIG_DINOSAUR_THRESHOLD = 4000
  CARNIVORE              = %w(carnivore insectivore piscivore)

  ATTRIBUTES             = [:name,
                            :period,
                            :continent,
                            :diet,
                            :weight_in_lbs,
                            :walking,
                            :description]

  attr_reader(*ATTRIBUTES)

  def initialize(params = {})
    ATTRIBUTES.each do |attr|
      instance_variable_set("@#{attr}", params[attr])
    end
  end

  def biped?
    @walking == BIPED
  end

  def carnivore?
    return false if @diet.nil?
    CARNIVORE.include?(@diet.downcase)
  end

  def big_dinosaur?
    @weight_in_lbs >= BIG_DINOSAUR_THRESHOLD
  end

  def display
    ATTRIBUTES.each { |attr| print_attribute(attr) }
  end

  def to_hash
    ATTRIBUTES.each_with_object({}) do |key, a|
      a.store(key, send(key) || "")
    end
  end

  private

  def titelize(key)
    key.to_s.split("_").map(&:upcase).join(" ")
  end

  def attribute_as_pair(key)
    [key, send(key)]
  end

  def print_attribute(key)
    return unless respond_to? key

    value = send(key)
    puts format("%-15s: %s", titelize(key), value) if value
  end
end
