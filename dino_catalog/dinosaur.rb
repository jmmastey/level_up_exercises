require_relative 'dino_parser'

class Dinodex
  attr_accessor :registry

  def initialize
    @registry = {}
  end

  def load_data(data)
    data.each do |row|
      @registry[row["name"]] = Dinosaur.new(row)
    end
  end

  def load_csv(filename)
    return false unless File.file?(filename)
    data = DinoTranslator.translate(DinoParser.parse_csv(filename))
    load_data(data) if DinoValidator.valid_data?(data)
  end
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

dinodex = Dinodex.new
ARGV.each do |arg|
  dinodex.load_csv(arg)
end
