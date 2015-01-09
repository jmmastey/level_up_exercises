require 'securerandom'

class Dinosaur

  attr_accessor :name, :period, :continent, :diet, :weight, :ambulation, :description

  def initialize(options = {})
    @name = options[:name] || nil
    @period = options[:period] || nil
    @continent = options[:continent] || nil
    @diet = options[:diet] || nil
    @weight = options[:weight] || nil
    @ambulation = options[:ambulation] || nil
    @description = options[:description] || nil
  end

  def to_hash
    Hash[*instance_variables.map { |v|
      [v.to_s.delete("@").to_sym, instance_variable_get(v)]
    }.flatten]
  end
end
