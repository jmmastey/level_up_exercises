class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :weight, :walking,
                :description

  def initialize(row)
    @name = row[:name]
    @period = row[:period]
    @continent = row[:continent]
    @diet = row[:diet]
    @weight = row[:weight_in_lbs]
    @walking = row[:walking]
    @description = row[:description]
  end

  def matches_period?(period)
    @period.include? period.value
  end

  def matches_weight_restriction?(min_weight)
    min_weight > @weight ? true : false
  end

  def matches_any?(criteria)
    criteria.any? { |key, match_value| send(key) == match_value }
  end

  def to_s
    "Dinosaur Info \n Name: #{@name} Period: #{@period}
    Continent: #{@continent} Diet: #{@diet} Weight: #{@weight}
    Walking: #{@walking} Description: #{@description}"
  end
end
