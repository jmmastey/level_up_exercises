require_relative 'dino_parser'

class String
  def alpha?
    !match(/[^[:alnum:]]/)
  end

  def number?
    true if Float(self) rescue false
  end
end

class Dinodex
  @registry = []
end

class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :weight, :walking, :desc

  def initialize(args = {})
    @name = args[:name]
    @period = args[:period]
    @continent = args[:continent]
    @diet = args[:diet]
    @weight = args[:weight]
    @walking = args[:walking]
    @desc = args[:desc]
  end

  def valid_input?(args)
    args[:name] &&
      args[:period] &&
      args[:continent] &&
      args[:diet] &&
      args[:weight] &&
      args[:walking] &&
      args[:desc]
  end

  def valid_name?(name)
    name.alpha?
  end

  def valid_period?(period)
    period.alpha?
  end

  def valid_continent?(continent)
    continent.alpha?
  end

  def valid_diet?(diet)
    diet.alpha?
  end

  def valid_weight?(weight)
    weight.number?
  end

  def valid_walking?(walking)
    walking.alpha?
  end

  def valid_desc?(desc)
    true
  end
end

dinosaurs = []
ARGV.each do |arg|
  dinosaurs += DinoParser.parse_csv(arg) if File.file?(arg)
end
puts dinosaurs
