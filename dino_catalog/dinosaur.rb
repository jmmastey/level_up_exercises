class Dinosaur
  attr_reader :name, :period, :continent, :diet, :carnivore,
    :weight, :locomotion, :description, :name_col, :weight_col

  def initialize(row)
    @name = row[:name]
    @period = row[:period]
    @continent = row[:continent]
    @diet = row[:diet]
    @carnivore = row[:carnivore]
    @weight = row[:weight].to_i if row[:weight]
    @locomotion = row[:locomotion]
    @description = row[:description]
  end

  def locomotion?(search_val)
    locomotion.downcase.chomp.include? search_val if locomotion
  end

  def diet?(search_val)
    diet.downcase.chomp.include? search_val if diet
  end

  def period?(search_val)
    period.downcase.chomp.include? search_val if period
  end

  def size?(search_val)
    return big? if search_val == "big"
    return small? if search_val == "small"
  end

  def weight?(search_val)
    @weight == search_val.to_i if @weight
  end

  def big?
    @weight > 4000 if @weight
  end

  def small?
    @weight <= 4000 if @weight
  end
end
