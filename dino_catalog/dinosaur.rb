require_relative 'dino_parser'

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
end

dinosaurs = []
ARGV.each do |arg|
  dinosaurs += DinoParser.parse_csv(arg) if File.file?(arg)
end
puts dinosaurs
