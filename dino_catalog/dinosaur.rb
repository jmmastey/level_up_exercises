class Dino
  WEIGHT_LIMIT = 4000

  attr_accessor :name, :period, :continent, :diet, :weight_in_lbs, :walking, :description

  def initialize(dino_hash)
    dino_hash.each { |k, v| send("#{k}=", v) }
  end

  def fat?
    @weight_in_lbs && @weight_in_lbs > WEIGHT_LIMIT
  end

  def small?
    @weight_in_lbs && @weight_in_lbs <= WEIGHT_LIMIT
  end

  def biped?
    @walking.eql? "biped"
  end

  def quadruped?
    @walking.eql? "quadruped"
  end

  def carnivore?
    %w( carnivore insectivore piscivore ).include? @diet
  end

  def herbivore?
    @diet.eql? "herbivore"
  end

  def to_s
    dino_facts = instance_variables.map do |dino_attribute|
      if instance_variable_get(dino_attribute)
        "#{dino_attribute[1..-1].capitalize}: \n "\
        "#{instance_variable_get(dino_attribute)}\n"
      end
    end.compact
  end

end