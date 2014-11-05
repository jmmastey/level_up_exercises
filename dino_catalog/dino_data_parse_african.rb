require 'csv'
require_relative 'dino'

class DinoDataParserAfrican
  attr_accessor :file, :dinos

  def initialize(file)
    @file = file
    @dinos = parse
  end

  def parse
    data = []

    CSV.foreach(@file, parse_opts) do |row|
      row = row.to_hash
      row[:continent] = 'Africa'
      data << Dinosaur.new(row)
    end
    data
  end

  def parse_opts
    {
      headers:            true,
      return_headers:     false,
      header_converters:  [:remap],
      converters:         [:all, :diet],
    }
  end

  # Don't think we can chain :header_converters like we can regular converters,
  # so lets to downcase, to_sym, and remap all in one...
  CSV::HeaderConverters[:remap] = lambda do |header|
    africa_dino_key_mapping = {
      genus:      :name,
      carnivore:  :diet,
      weight:     :weight_in_lbs,
    }
    header = header.downcase.to_sym
    return header if africa_dino_key_mapping[header].nil?
    africa_dino_key_mapping[header]
  end

  CSV::Converters[:diet] = lambda do |field, fieldinfo|
    return field unless fieldinfo.header == :diet
    (field == 'Yes') ? 'Carnivore' : 'Non Carnivore'
  end
end
