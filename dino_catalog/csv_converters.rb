#!/usr/bin/env ruby
# File csv_converters.rb
require 'csv'
INPUT_YES   = 'yes'
INPUT_NO    = 'no'
DIET_HEADER = 'diet'

CSV::HeaderConverters[:africa] = lambda do |header|
  head = header
  head = :name if header.to_s.downcase == 'genus'
  head = :diet if header.to_s.downcase == 'carnivore'
  head
end

CSV::HeaderConverters[:weight] = lambda do |header|
  head = header
  head = :weight if header.to_s.downcase == 'weight_in_lbs'
  head
end

CSV::Converters[:weight_in_lbs] = lambda do |weight, field_info|
  if field_info[:header].to_s == 'weight'
    weight.to_i * 2.20462
  else
    weight
  end

end

CSV::Converters[:blank] = lambda do |value|

  if value
    value
  else
    ''
  end
end

CSV::Converters[:diet] = lambda do |diet, field_info|
  diet_return = diet
  if field_info[:header].to_s == DIET_HEADER

    diet_input = diet.to_s.downcase

    if diet_input == INPUT_YES || diet_input == INPUT_NO
      diet_return = 'Carnivore' if diet_input == INPUT_YES
      diet_return = '' if diet_input == INPUT_NO
    end
  end

  diet_return
end
