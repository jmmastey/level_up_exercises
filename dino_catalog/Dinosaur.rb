class Dinosaur
  attr_reader :name, :period, :continent, :carnivore, \
    :diet, :weight, :walking, :descriptor

  CARNIVORE_DIET = %w(insectivore piscivore carnivore)
  def initialize(params = {})
    params.each { |name, value| instance_variable_set("@#{name}", value) unless value.nil? }
    (@carnivore = 'Yes' if CARNIVORE_DIET.include?(@diet.downcase))\
     unless diet.nil?
  end

  def all_variables
    attributes = {}
    instance_variables.each do |var|
      unless instance_variable_get(var).nil?
        attributes["------\n" + var.to_s.tr('@', '').capitalize] \
        = (instance_variable_get(var).to_s + "\n------")
      end
    end
    attributes
  end
end

# dino = Dinosaur.new(name:"Claw")
# puts dino.all_variables
