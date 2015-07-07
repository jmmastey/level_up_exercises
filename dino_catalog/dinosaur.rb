class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :weight, :movement,
    :description

  HEADERS = %w(Name Period Continent Diet Weight Movement Description)
  MAX_SMALL_WEIGHT = 2000

  def self.columns
    HEADERS.map(&:downcase)
  end

  def self.big(data_set)
    data_set.select { |_name, dinosaur| dinosaur.big? }
  end

  def self.small(data_set)
    data_set.select { |_name, dinosaur| dinosaur.small? }
  end

  def initialize(data)
    data.each do |header, value|
      method("#{header}=").call(value)
    end
  end

  def big?
    self.weight.to_i > MAX_SMALL_WEIGHT
  end

  def small?
    self.weight.to_i <= MAX_SMALL_WEIGHT
  end
end
