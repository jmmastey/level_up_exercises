class Dinosaur
  attr_accessor :genus, :period, :diet, :weight, :numlegs, :continent, :description

  SMALL = 2000

  SORTED_FIELDS = [:genus, :period, :diet, :weight, :numlegs, :continent, :description]

  def initialize(classifications = {})
    @genus       = classifications[:genus]
    @period      = classifications[:period]
    @diet        = classifications[:diet]
    @weight      = classifications[:weight]
    @numlegs     = classifications[:numlegs]
    @continent   = classifications[:continent]
    @description = classifications[:description]
  end

  def gigantic?
    @weight > SMALL
  end

  def eats_meat?
    ['carnivore', 'insectivore', 'piscivore'].include? @diet.downcase
  end

  def biped?
    numlegs == 'Biped'
  end

  def from_period?(period_name)
    @period =~ /#{period_name}/i
  end

  def to_s
    to_h.map do |_key, val|
      "#{val}".ljust(20)
    end.join("") + "\n"
  end

  private

  def to_h
    SORTED_FIELDS.each_with_object({}) do |field, output|
      output[field] = instance_variable_get("@#{field}")
    end
  end
end
