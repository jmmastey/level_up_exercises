require 'json'

class Dino
  attr_reader :name, :period, :continent, :diet, :weight, :walking, :description

  def initialize(args = {})
    @name             = args[:name]
    @period           = args[:period]
    @continent        = args[:continent]
    @diet             = args[:diet]
    @weight           = args[:weight_in_lbs]
    @walking          = args[:walking]
    @description      = args[:description]
  end

  alias_method :to_s, :name

  def biped
    walking == 'Biped'
  end

  def carnivore
    %(Carnivore Insectivore Piscivore).include? diet if diet
  end

  def big
    weight.to_i > 2000 if weight
  end

  def small
    weight.to_i <= 2000 if weight
  end

  def to_h
    instance_variables.each_with_object({}) do |i, hash|
      key = i.to_s.gsub('@', '')
      hash[key] = send(key) unless send(key).nil?
    end
  end

  def facts
    to_h.map { |k, v| "#{k.capitalize}: #{v.to_s.capitalize}" }
  end

  def to_json(_opts = {})
    to_h.to_json
  end
end

class AfricanDino < Dino
  attr_reader :carnivore

  def initialize(args = {})
    super
    @continent = "Africa"
    @name      = args[:genus]
    @carnivore = args[:carnivore] == 'Yes'
    @weight    = args[:weight]
    @diet      = 'Carnivore' if @carnivore
  end
end
