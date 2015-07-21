class Dinosaur
  CARNIVORES = %w(carnivore insectivore piscivore omnivore)
  TWO_TONS = 4000

  ATTRS = [:name, :period, :continent, :diet, :weight, :walking, :description]
  ATTRS.freeze
  attr_accessor(*ATTRS)

  def initialize(options = {})
    @name = options[:name]
    @period = options[:period]
    @continent  = options[:continent]
    @diet = options[:diet]
    @weight = options[:weight]
    @walking = options[:walking]
    @description = options[:description]
  end

  def searchable_attrs
    attr_symbols = ATTRS + [:size, :carnivore]
    attr_symbols.map(&:id2name)
  end

  def size
    return if weight.nil?
    weight.to_f > TWO_TONS ? "big" : "small"
  end

  def carnivore
    carnivore?.to_s
  end

  def carnivore?
    return false if diet.nil?
    CARNIVORES.include? diet.to_s.downcase
  end

  def to_s
    strings = ATTRS.each_with_object([]) { |attr, str| str << attr_to_s(attr) }
    strings.compact.reject(&:empty?).join(', ')
  end

  def attr_to_s(attr)
    value = method(attr).call
    return "" if value.nil?
    "#{attr.capitalize}: #{value}"
  end

  def to_h
    ATTRS.each_with_object({}) do |attr, h|
      value = method(attr).call
      h["#{attr.capitalize}"] = value unless value.nil?
    end
  end

  # Defining comparison operators for easier testing with Minitest.
  def <=>(other)
    compare_by_attr_values(other)
  end

  def ==(other)
    compare_by_attr_values(other) == 0
  end

  def <(other)
    compare_by_attr_values(other) == -1
  end

  def >(other)
    compare_by_attr_values(other) == 1
  end

  def compare_by_attr_values(other)
    ATTRS.each do |attr|
      value = method(attr).call
      other_value = other.method(attr).call
      comparison = value <=> other_value
      return comparison unless comparison == 0
    end
    0
  end
end
