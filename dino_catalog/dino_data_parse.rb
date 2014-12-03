require 'csv'
require_relative 'dino'

class DinoDataParser
  def parse(file)
    dinosaurs(file)
  end

  def parse_african(file)
    dinosaurs(file, converters: [:all, :diet]) do |row|
      row[:continent] = 'Africa'
    end
  end

  private

  def dinosaurs(file, parse_opts = {})
    csv_data(file, parse_opts).map do |row|
      yield(row) if block_given?
      Dinosaur.new(row)
    end
  end

  def csv_data(file, parse_opts, csv_data = [])
    CSV.foreach(file, PARSE_OPTS.merge!(parse_opts)) do |row|
      csv_data << row.to_hash
    end
    csv_data
  end

  PARSE_OPTS = {
    headers:           true,
    return_headers:    false,
    header_converters: [:remap],
  }

  CSV::HeaderConverters[:remap] = lambda do |header|
    header = header.downcase.to_sym
    case header
      when :genus     then :name
      when :carnivore then :diet
      when :weight    then :weight_in_lbs
      else header
    end
  end

  CSV::Converters[:diet] = lambda do |field, fieldinfo|
    return field unless fieldinfo.header == :diet
    (field == 'Yes') ? 'Carnivore' : 'Non Carnivore'
  end
end
