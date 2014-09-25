require "json"

class Dino
  attr_reader :name, :period, :continent, :diet, :carnivore, :weight,
    :walking, :description

  def initialize(params = {})
    params.each { |key, value| instance_variable_set("@#{key}", value) }
    raise "Dino name is reqired parameter." unless @name
    @weight = @weight.to_f if @weight
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
    instance_variables.each_with_object({}) do |var, hash|
      hash[var.to_s.delete("@")] = instance_variable_get(var)
    end
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
