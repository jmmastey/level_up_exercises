require 'json'

class Dinosaur
  TWO_TONS = 4480
  WHITELIST_ATTR = %w(name period continent diet weight walking description)

  attr_accessor :name, :period, :continent, :diet, :weight, :walking
  attr_accessor :description

  def initialize(args = {})
    args.each_pair do |key, value|
      send("#{key}=", value)
    end
  end

  def carnivore?
    return false if diet.nil?
    %w(Carnivore Piscivore Insectivore).include?(diet)
  end

  def biped?
    return false if walking.nil?
    walking == "Biped"
  end

  def big?
    return false if weight.nil?
    weight.to_i > TWO_TONS
  end

  def small?
    return false if weight.nil?
    !big?
  end

  def from_period?(prd)
    return false if period.nil?
    period.include?(prd)
  end

  def print_facts
    to_hash.each_pair do |key, value|
      puts "#{key}: #{value}" unless value.nil?
    end
    puts
  end

  def to_hash
    WHITELIST_ATTR.map do |iv|
      [iv.to_sym, instance_variable_get('@' << iv)]
    end.to_h
  end

  def to_json
    to_hash.to_json
  end
end
