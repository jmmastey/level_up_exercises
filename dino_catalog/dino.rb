class Dinosaur
  attr_reader :name, :period, :continent, :diet, :weight, :walk, :desc
  def initialize(values)
    @name = values[:name]
    @period = values[:period]
    @continent = values[:continent]
    @diet = values[:diet]
    @weight = values[:weight]
    @walk = values[:walk]
    @desc = values[:desc]
  end

  def to_s
    <<END
=== #{name} ===
period: #{period}
contnent: #{continent}
diet: #{diet}
weight: #{(weight == -1) ? "" : weight}
walk: #{walk}
description: #{desc}
END
  end
end
