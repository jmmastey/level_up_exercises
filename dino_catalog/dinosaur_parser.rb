require "csv"
require_relative "dinosaur.rb"

class DinosaurParser
  HEADERS          = Dinosaur::ATTRS

  HEADER_ALIASES   = {
    "genus" => "name",
    "weight_in_lbs" => "weight",
    "carnivore" => "diet",
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
      header_converters: csv_header_converters,
      converters: csv_value_converters,
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
    @csv_rows.each do |row|
      HEADERS.each do |header|
        row[header] = DEFAULT_VALUES[header] unless row[header]
      end
    end
  end

  def methods_to_lambdas(methods)
    methods.map { |m| lambda(&method(m)) }
  end

  def csv_header_converters
    converters = [:header_converter]
    methods_to_lambdas(converters)
  end

  def csv_value_converters
    converters = [:diet_converter, :period_converter, :weight_converter]
    methods_to_lambdas(converters)
  end

  def header_converter(header)
    header.downcase.tap do |h|
      header_alias = HEADER_ALIASES[h]
      h.replace(header_alias) if header_alias
    end.to_sym
  end

  def diet_converter(value, fields)
    return value unless (fields.header == :diet) && (value =~ /^(Yes|No)$/)
    value == 'Yes' ? DIET_CARNIVORE : DIET_HERBIVORE
  end

  def period_converter(value, fields)
    return value unless (fields.header == :period) && (value =~ /Cretaceous/i)
    CRETACEOUS
  end

  def weight_converter(value, fields)
    return value unless (fields.header == :weight)
    value.to_i
  end
end
