class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :weight, :movement,
    :description

  HEADERS = %w(Name Period Continent Diet Weight Movement Description)

  def self.columns
    HEADERS.map(&:downcase)
  end

  def initialize(data)
    data.each do |header, value|
      method("#{header}=").call(value)
    end
  end
end
