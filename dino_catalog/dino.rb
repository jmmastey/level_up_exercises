class Dino
  attr_reader :all_info, :name, :period, :continent, :diet,
    :weight, :walking, :description

  def initialize(row)
    @all_info = row.to_s
    @name = row[:name]
    @period = row[:period]
    @continent = row[:continent]
    @diet = row[:diet]
    @weight = row[:weight]
    @walking = row[:walking]
    @description = row[:description]
  end
end
