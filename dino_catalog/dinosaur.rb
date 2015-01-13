require 'securerandom'

class Dinosaur

  attr_accessor :name, :period, :continent, :diet, :weight, :ambulation, :description

  def initialize(options = {})
    @name = lower_case(options[:name]) || nil
    @period = lower_case(options[:period]) || nil
    @continent = lower_case(options[:continent]) || nil
    @diet = lower_case(options[:diet]) || nil
    @weight = options[:weight] || nil
    @ambulation = lower_case(options[:ambulation]) || nil
    @description = lower_case(options[:description]) || nil
  end

  def to_hash
    Hash[*instance_variables.map { |v|
      [v.to_s.delete("@").to_sym, instance_variable_get(v)]
    }.flatten]
  end

  def lower_case(attribute)
    if attribute.nil?
      return false
    else
      attribute.downcase
    end
  end
end
