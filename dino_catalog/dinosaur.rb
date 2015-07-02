class Dinosaur
  %i(
    name
    period
    continent
    diet
    weight
    movement
    description
  ).each { |s| attr_accessor s }

  HEADERS = %w(Name Period Continent Diet Weight Movement Description)

  def self.headers
    columns = []
    HEADERS.each { |header| columns << header.downcase }
    columns
  end

  def initialize(data)
    data.each do |header, value|
      method("#{header}=").call(value)
    end
  end
end
