class Dinosaur
  attr_accessor :genus, :period, :diet, :weight, :numlegs, :continent, :desc

  def initialize(classifications = {})
    @genus       = classifications[:genus]
    @period      = classifications[:period]
    @diet        = classifications[:diet]
    @weight      = classifications[:weight]
    @numlegs     = classifications[:numlegs]
    @continent   = classifications[:continent]
    @description = classifications[:desc]
  end

  def large
    4000
  end

  def small
    2000
  end

  def eats_meat?
    ["carnivore", "insectivore", "piscivore"].include? @diet.downcase
  end

  def biped?
    numlegs == "Biped"
  end

  def from_period?(period_name)
    @period.downcase.include? period_name.downcase
  end

  def to_s
    to_hash.map do |_key, val|
      truncate("#{val}")
    end.join("\t\t") + "\n"
  end

  private

  def to_hash
    hash = {}
    instance_variables.each do |var|
      hash[var.to_s.delete("@")] = instance_variable_get(var)
    end
    hash
  end

  def truncate(text)
    if text == "Quadruped"
      text.slice(0, 4)
    elsif text == "Albian"
      "Albian  "
    else
      text.slice(0, 15)
    end
  end
end
