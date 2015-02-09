class Dinosaur
  attr_accessor :name, :period, :continent, :diet,
    :weight, :walking, :description

  def initialize(attributes)
    @name = attributes["name"]
    @period = attributes["period"]
    @continent = attributes["continent"]
    @diet = attributes["diet"]
    @weight = attributes["weight"].to_i
    @walking = attributes["walking"]
    @description = attributes["description"]
  end

  def big?
    @weight > 2000
  end

  def small?
    @weight <= 2000
  end

  def to_s
    s = "#{@name} is a #{@walking} from #{@period} period and #{@continent} "
    s << "continent with #{@diet} diet"
    s << " and #{@weight}lbs weight" unless @weight == 0
    s << ". "
    s << @description unless @description.nil?
    s
  end
end
