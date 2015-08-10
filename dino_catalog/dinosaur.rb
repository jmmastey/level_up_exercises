class Dinosaur
  attr_accessor :name, :period, :continent, :diet
  attr_accessor :weight, :walking, :description

  alias_method :genus=, :name=
  alias_method :weight_in_lbs=, :weight=

  def initialize(args = {})
    args.each do |key, value|
      send("#{key.downcase}=", value)
    end
  end

  def carnivore
    @diet.downcase != "herbivore"
  end

  def carnivore=(value)
    @diet = "Carnivore" if value.downcase == "yes"
    @diet = "Herbivore" if value.downcase == "no"
  end

  def to_s
    instance_variables.map do |ivar|
      vname = ivar.to_s
      vname[0] = ""

      value = instance_variable_get(ivar)

      "#{vname.capitalize}: #{value}" if value
    end
  end
end
