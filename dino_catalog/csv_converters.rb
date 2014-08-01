#!/usr/bin/env ruby
# File csv_converters.rb
require 'csv'

CSV::HeaderConverters[:africa] = lambda do |header|
  head = header
  head = :name if header.to_s.downcase  == 'genus'
  head = :diet if header.to_s.downcase  == 'carnivore'
  head
end

CSV::HeaderConverters[:weight] = lambda do |header|
  head = header
  head = :weight if header.to_s.downcase == 'weight_in_lbs'
  head
end

CSV::Converters[:weight_in_lbs] = lambda do |weight, field_info|
  if field_info[:header].to_s == 'weight'
    (weight.to_i * 2.20462).to_s
  end
  end

CSV::Converters[:diet] = lambda do |diet|
  diet_input = diet.to_s.downcase

  carnivore = 'Carnivore' if diet_input == 'yes'

  if diet_input != 'no'
    carnivore ||= diet
  else
    carnivore = nil
  end

  carnivore
end