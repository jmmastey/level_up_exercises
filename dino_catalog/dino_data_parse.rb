require 'csv'
require_relative 'dino'

class DinoDataParser
  def self.parse(file)
    data = []
    csv_parse(file, nil) do |row|
      data << Dinosaur.new(row)
    end
    data
  end

  def self.parse_african(file)
    data = []
    csv_parse(file, converters: [:all, :diet]) do |row|
      row[:continent] = 'Africa'
      data << Dinosaur.new(row)
    end
    data
  end

  private

  def self.csv_parse(file, parse_opts)
    CSV.foreach(file, PARSE_OPTS.merge!(parse_opts || {})) do |row|
      yield(row.to_hash)
    end
  end

  PARSE_OPTS = {
    headers:           true,
    return_headers:    false,
    header_converters:  [:remap],
  }

  # Don't think we can chain :header_converters like we can regular converters,
  # so lets to downcase, to_sym, and remap all in one...
  CSV::HeaderConverters[:remap] = lambda do |header|
    header = header.downcase.to_sym
    case header
      when :genus then :name
      when :carnivore then :diet
      when :weight then :weight_in_lbs
      else header
    end
  end

  CSV::Converters[:diet] = lambda do |field, fieldinfo|
    return field unless fieldinfo.header == :diet
    (field == 'Yes') ? 'Carnivore' : 'Non Carnivore'
  end
end
