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

CSV::Converters[:weight_in_lbs] = lambda do |weight|
  weight
end