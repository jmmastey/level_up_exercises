require "csv"

require_relative "dinosaur"

class DinoFile
  attr_accessor :path, :reader

  HEADER_FORMATS = {
    "genus,period,carnivore,weight,walking" => :p_b_africa,
    "name,period,continent,diet,weight_in_lbs,walking,description" => :original,
  }

  def initialize(path: nil)
    @path = path
    @reader = format_specific_reader unless path.nil?
  end

  def format_specific_reader
    format = identify_format
    lambda do
      converter_method = method("#{format}_format_to_dinosaur")
      csv_file_to_h.map do |dino|
        converter_method.call(dino)
      end
    end
  end

  def identify_format
    File.open(path) do |file|
      line = file.readline
      sanitized_line = line.downcase.strip
      format = HEADER_FORMATS[sanitized_line]
      raise(DinoBadFormat, "Unknown format in file: #{path}") if format.nil?
      format
    end
  end

  def original_format_to_dinosaur(dino)
    dino[:weight] = dino[:weight_in_lbs]
    Dinosaur.new(dino)
  end

  def p_b_africa_format_to_dinosaur(dino)
    dino[:continent] = "Africa"
    dino[:name] = dino[:genus]
    if dino.key?(:carnivore)
      dino[:diet] = dino[:carnivore] == "Yes" ? "Carnivore" : "Herbivore"
    end
    Dinosaur.new(dino)
  end

  def csv_file_to_h
    CSV::Converters[:blank_to_nil] = blank_to_nil_converter
    options = { converters: :blank_to_nil, headers: true, return_headers: false,
                header_converters: :symbol }
    CSV.open(path, options) do |csv|
      csv.to_a.map(&:to_hash)
    end
  end

  def blank_to_nil_converter
    lambda do |field|
      field && field.empty? ? nil : field
    end
  end

  def read
    reader.call
  end
end

class DinoBadFormat < StandardError
end
