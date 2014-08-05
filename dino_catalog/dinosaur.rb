#!/usr/bin/env ruby
# File dinosaur.rb
class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :weight, :walking, :description
  HEADERS = %w(Name Period Continent Diet Weight Walking Description)
  # alias_method :weight_in_lbs, :weight

  def initialize(options={})
    new_from_data(options)
    # self.name = options[:name] || nil
    # self.period = options[:period] || nil
    # self.continent = options[:continent] || nil
    # self.diet = options[:diet] || nil
    # self.weight = options[:weight] || options[:weight_in_lbs] || 0
    # self.walking = options[:walking] || nil
    # self.description = options[:description] || nil
  end

  def new_from_data(data)
    data.each do |var, value|
      begin
        method("#{var}=").call(value)
      rescue
        match = var.to_s.match(/^weight/)
        if match
          method(:weight=).call(value)
        end
      end
    end
  end

  def weight=(new_weight)
    @weight = new_weight

  end

  def table_display
    display = []
    HEADERS.each { |field| display << method("#{field}".downcase).call }
    display
  end

  def to_s
    "#{description} #{period} #{continent} #{diet} #{weight} #{walking}"
  end
end