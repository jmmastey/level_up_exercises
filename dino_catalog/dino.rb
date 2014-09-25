require "json"

class Dino
  attr_reader :name, :period, :continent, :diet, :carnivore, :weight,
    :walking, :description

  def initialize(name, options = {})
    @name = name
    @period = options[:period]
    @continent = options[:continent]
    @diet = options[:diet]
    @carnivore = options[:carnivore]
    @weight = options[:weight].to_f if options[:weight]
    @walking = options[:walking]
    @description = options[:description]
  end

  def match?(criteria)
    criteria.all? do |field, value|
      match(send(field), value) if respond_to?(field)
    end
  end

  def to_s
    to_h.map { |(key, value)| "#{key}: #{value}" if value }.join(" | ")
  end

  def to_h
    {
      name: name,
      period: period,
      continent: continent,
      carnivore: carnivore,
      diet: diet,
      weight: weight,
      walking: walking,
      description: description,
    }
  end

  def to_json(*args)
    to_h.to_json(*args)
  end

  private

  def match(left, right)
    if left.nil?
      right.nil?
    elsif right.is_a? Array
      left.send(right[0], right[1])
    elsif right.is_a? String
      /#{right}/ =~ left
    else
      left == right
    end
  end
end
