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
  end

  def self.parse(filename)
    if valid_file?(filename)
      process(filename)
    else
      err = "ERROR: #{filename} either does not exist or is not a csv file"
      $stderr.puts err
    end
  end

  def self.process(filename)
    rows      = CSV.read filename, headers: true

    rows.inject([]) do |a, e|
      params = process_row(e)
      a << Dinosaur.new(params)
    end
  end

  def self.process_row(row)
    default_hash = create_default_params

    row.each do |header, value|
      header = process_header(header)
      default_hash[header.to_sym] = value if header
    end

    default_hash.each_with_object({}) do |(key, value), hash|
      hash[key] = process_value(key.to_s, value)
    end
  end

  def self.process_header(header)
    header = header.downcase.gsub(" ", "_")

    if HEADERS_ALLOWED.include?(header)
      header
    elsif HEADERS_ALLOWED.include?(HEADER_ALIASES[header])
      HEADER_ALIASES[header]
    end
  end

  def self.process_value(header, value)
    return value unless CONVERTERS.include?(header)

    send(CONVERTERS[header], value)
  end

  def self.create_default_params
    unless @param_hash
      @param_hash = HEADERS_ALLOWED.each_with_object({}) do |header, hash|
        hash[header.to_sym] = nil
      end
    end

    @param_hash.clone
  end

  def self.valid_file?(filename)
    (File.extname(filename) == ".#{CSV_EXTENSION}") && (File.exist?(filename))
  end

  def self.diet_converter(value)
    if value.casecmp("yes") == 0
      DIET_CARNIVORE
    elsif value.casecmp("no") == 0
      DIET_HERBIVORE
    else
      value
    end
  end

  def self.continent_converter(value)
    value || CONTINENT_AFRICA
  end
end
