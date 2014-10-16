require "csv"
require_relative "dinosaur.rb"

class DinosaurParser
  CSV_EXTENSION    = "csv"
  HEADERS_ALLOWED  = Dinosaur::ATTRIBUTES
  
  DIET_CARNIVORE   = "carnivore"
  DIET_HERBIVORE   = "herbivore"

  CONTINENT_AFRICA = "Africa"

  HEADER_ALIASES   = {
    "genus" => "name",
    "weight" => "weight_in_lbs",
    "carnivore" => "diet",
  }

  CONVERTERS       = {
    "diet"  => :diet_converter,
    "continent" => :continent_converter,
  }

  class << self
    attr_accessor :param_hash

    def parse(filename)
      if valid_file?(filename)
        process(filename)
      else
        err = "ERR:#{filename} either does not exist or is not a csv file"
        $stderr.puts err
      end
    end

    def process(filename)
      dinosaurs = []
      rows      = CSV.read filename, headers: true

      rows.each do |row|
        params = process_row(row)
        dinosaurs << Dinosaur.new(params)
      end

      dinosaurs
    end

    def process_row(row)
      default_hash = create_default_params

      row.each do |header, value|
        if header = process_header(header)
          default_hash[header.to_sym] = value
        end
      end

      default_hash.each_with_object({}) do |(key, value), hash|
        hash[key] = process_value(key.to_s, value)
      end
    end

    def process_header(header)
      header = header.downcase.gsub(" ", "_")

      if HEADERS_ALLOWED.include?(header)
        header
      elsif HEADERS_ALLOWED.include?(HEADER_ALIASES[header])
        HEADER_ALIASES[header]
      else
        nil
      end
    end

    def process_value(header, value)
      return value unless CONVERTERS.include?(header)

      send CONVERTERS[header], value
    end

    def create_default_params
      unless @param_hash
        @param_hash = {}
        HEADERS_ALLOWED.each do |header|
          @param_hash[header.to_sym] = nil
        end
      end

      @param_hash.clone
    end

    def valid_file?(filename)
      (File.extname(filename) == ".#{CSV_EXTENSION}") && (File.exist?(filename))
    end

    def diet_converter(value)
      if value.casecmp("yes") == 0
        value = DIET_CARNIVORE
      elsif value.casecmp("no") == 0
        value = DIET_HERBIVORE
      end

      value
    end

    def continent_converter(value)
      (value ? value : CONTINENT_AFRICA)
    end
  end
end
