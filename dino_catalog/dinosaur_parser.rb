require "csv"
require_relative "dinosaur.rb"

class DinosaurParser
  CSV_EXTENSION   = "csv"
  HEADERS_ALLOWED = %w(name
                       period
                       continent
                       diet
                       weight_in_lbs
                       walking
                       description
                    )

  HEADER_ALIASES   = {
    "genus" => "name",
    "weight" => "weight_in_lbs",
    "carnivore" => "diet"
  }

  CONVERTERS       = {
    "diet"  => :diet_converter
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
        dinosaurs.push(Dinosaur.new(params))
      end

      dinosaurs
    end

    def process_row(row)
      hash = create_initial_param

      row.each do |column|
        if header = process_header(column[0])
          hash[header.to_sym] = process_value(header, column[1])
        end
      end
      hash
    end

    def process_value(header, value)
      return value unless CONVERTERS.include?(header)

      self.send(CONVERTERS[header], value)
    end

    def create_initial_param
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

    def process_header(header)
      header = header.downcase.gsub(" ", "_")

      if HEADERS_ALLOWED.include?(header)
        header
      elsif HEADERS_ALLOWED.include?(HEADER_ALIASES[header])
        HEADER_ALIASES[header]
      end
    end

    def diet_converter(value)
      if value.downcase == "yes"
        value = "Carnivore"
      elsif value.downcase == "no"
        value ="Herbivore"
      end

      value
    end
  end
end
