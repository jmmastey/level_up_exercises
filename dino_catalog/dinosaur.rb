class Dinosaur
  attr_accessor  :name, :period, :continent, :diet, :weight, :ambulation, :description

  def initialize(options = {})
    @name = options[:name]
    @period = options[:period]
    @continent = options[:continent]
    @diet = options[:diet]
    @weight = options[:weight]
    @ambulation = options[:ambulation]
    @description = options[:description]
  end

  def to_hash
    Hash[*instance_variables.map { |v|
      [v.to_s.delete("@").to_sym, instance_variable_get(v)]
    }.flatten]
  end

end
