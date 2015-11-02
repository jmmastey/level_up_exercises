class Dinosaur

  attr_accessor :name, :period, :continent, :diet, :weight_lbs, :walking, :description

  def initialize(opts={})
    @name = opts[:name]
    @period = opts[:period]
    @continent = opts[:continent]
    @diet = opts[:diet]
    @weight_lbs = opts[:weight_lbs]
    @walking = opts[:walking]
    @description = opts[:description]
  end

  def biped?
    @walking == "Biped"
  end

  def big?
    @weight_lbs > 2000
  end

  def small?
    @weight_lbs < 2000 && @weight_lbs != 0
  end

  def carnivore?
    # Include fish and insects due to requirements
    ["Carnivore", "Insectivore", "Piscivore"].any? { |opt| @diet == opt }
  end

  def display
    pretty_string = "#######################\nHere are my details!!\n#######################\n"
    instance_variables.each do |var|
      pretty_string += "#{var.to_s.sub("@", "").capitalize} -> #{instance_variable_get(var)}\n" unless instance_variable_get(var) == nil
    end
    pretty_string += "#######################\n"
    return pretty_string
  end

end
