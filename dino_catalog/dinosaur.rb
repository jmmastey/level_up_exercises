class Dinosaur
  attr_reader :name, :period, :continent, :diet, :weight, :walking, :description

  def initialize(name, attr = {})
    @name = name
    # allowed attributes
    attr.each { |k, v| instance_variable_set("@#{k}", v) }
    # @period = attr[:period]
    # @continent = attr[:continent]
    # @diet = attr[:diet]
    # @weight = attr[:weight]
    # @walking = attr[:walking]
    # @description = attr[:description]
  end

  def carnivore?
    carnivorous = %w(Carnivore Insectivore Piscivore)
    carnivorous.include?(@diet)
  end

  def what_size?
    return "Unknown" if @weight.nil?
    @weight >= 2000 ? "Big - Over a ton" : "Small - Under a ton"
  end

  def to_hash
    hash = {}
    instance_variables.each do |var|
      hash[var.to_s.delete("@")] = instance_variable_get(var)
    end
    hash
  end

  def to_s
    pad = 15
    record = ''
    record << "-" * 100 + "\n"
    record << "Name:".ljust(pad) + "#{@name}\n" unless @name == ""
    record << "Period:".ljust(pad) + "#{@period}\n" unless @period == ""
    record << "Continent:".ljust(pad) + "#{@continent}\n" \
      unless @continent == ""
    record << "Diet:".ljust(pad) + "#{@diet}\n" unless @diet == ""
    record << "Weight:".ljust(pad) + "#{@weight}\n" unless @weight.nil?
    record << "Walking:".ljust(pad) + "#{@walking}\n" unless @walking == ""
    record << "Description:".ljust(pad) + "#{@description}\n" \
      unless @description == "" || @description.nil?
    record << "-" * 50 + "\n"
    record
  end
end
