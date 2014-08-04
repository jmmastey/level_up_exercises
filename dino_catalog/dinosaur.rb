#!/usr/bin/env ruby
# File dinosaur.rb
class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :weight, :walking, :description

  def initialize(options={})
    self.name = options[:name] || nil
    self.period = options[:period] || nil
    self.continent = options[:continent] || nil
    self.diet = options[:diet] || nil
    self.weight = options[:weight] || options[:weight_in_lbs] || 0
    self.walking = options[:walking] || nil
    self.description = options[:description] || nil
  end

  def to_s
    "#{description} #{period} #{continent} #{diet} #{weight} #{walking}"
  end
end