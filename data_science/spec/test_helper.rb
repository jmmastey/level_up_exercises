require 'abanalyzer'
require 'rspec'
require_relative '../data_conversion_loader'
require_relative '../sample'
require_relative '../sample_comparer'

DATA_FIELDS = %w(date cohort result)
DATA_SIZE = 1349
DATA_CONVERSIONS_A = 47
DATA_NON_CONVERSIONS_A = 1302
CONFIDENCE = 0.95

def conversion_data
  DataConversionLoader.new("source_data.json").data
end

def conversion_data_a
  DataConversionLoader.new("source_data.json").sample_data("A")
end

def conversion_data_b
  DataConversionLoader.new("source_data.json").sample_data("B")
end
