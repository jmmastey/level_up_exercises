require 'pry'
class Dinosaur
  attr_accessor :name, :period, :continent, :diet,
    :weight, :walking, :description

  WEIGHT_DIFFERENTIATOR = 2000
  def initialize(attributes)
    @name = attributes[:name]
    @period = attributes[:period]
    @continent = attributes[:continent]
    @diet = attributes[:diet]
    @weight = attributes[:weight]
    @walking = attributes[:walking]
    @description = attributes[:description]
  end

  def big?
    !@weight.nil? && @weight.to_i > WEIGHT_DIFFERENTIATOR
  end

  def small?
    !@weight.nil? && !big?
  end

  def carnivore?
    %w(carnivore insectivore piscivore).include? @diet.downcase
  end

  def to_s
    s = "#{@name} is a #{@walking} from #{@period} period and #{@continent} "
    s << "continent with #{@diet} diet"
    s << " and #{@weight}lbs weight" unless @weight.nil?
    s << ". "
    s << @description unless @description.nil?
    s
  end
end
