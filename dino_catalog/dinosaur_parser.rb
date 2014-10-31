require "csv"
require_relative "dinosaur.rb"

class DinosaurParser
  HEADERS          = Dinosaur::ATTRIBUTES

  HEADER_ALIASES   = {
    genus: :name,
    weight: :weight_in_lbs,
    carnivore: :diet,
  }

  DEFAULT_VALUES = {
    continent: "Africa",
  }

  DIET_CARNIVORE   = "Carnivore"
  DIET_HERBIVORE   = "Herbivore"
  CRETACEOUS       = "Cretaceous"

  def initialize(filename)
    validate(filename)

    @csv_rows = CSV.read(filename,
      headers: true,
      header_converters: header_converters,
      converters: converters,
    )

    fix_missing_headers
  end

  def validate(filename)
    return if valid?(filename)
    raise "#{filename} does not exist or is not a csv file"
  end

  def valid?(filename)
    (File.extname(filename) == ".csv") && (File.exist?(filename))
  end

  def parse
    @csv_rows.inject([]) { |a, e| a << Dinosaur.new(e.to_hash) }
  end

  private

  def fix_missing_headers
    @csv_rows.each do |r|
      HEADERS.each { |h| r << [h, DEFAULT_VALUES[h]] unless r[h] }
    end
  end

  def header_converters
    [
      ->(h) { h.downcase },
      lambda(&method(:dinosaur_header_converter)),
      :symbol,
    ]
  end

  def converters
    [lambda(&method(:dinosaur_diet_converter)),
     lambda(&method(:dinosaur_period_converter))]
  end

  def dinosaur_header_converter(header)
    HEADER_ALIASES[header.to_sym] || header
  end

  def dinosaur_diet_converter(value, fields)
    return value unless (fields.header == :diet) && (value =~ /^(Yes|No)$/)
    value == 'Yes' ? DIET_CARNIVORE : DIET_HERBIVORE
  end

  def dinosaur_period_converter(value, fields)
    return value unless (fields.header == :period) && (value =~ /Cretaceous/i)
    CRETACEOUS
  end
end
