#!/usr/bin/env ruby

$LOAD_PATH << './lib'

require 'hirb'
require 'data_loader'
require 'test_data'

class SplitTestAnalyzer
  attr_reader :data

  def initialize(data)
    extend Hirb::Console

    data_source = DataLoader.new(data)
    @data = TestData.new(data_source.load_data, 'cohort')
    data_table
  end

  def data_table
    puts
    table(display_data,
      headers: ['Groups', 'Sample Size', 'Conversions', 'Percentages'],
      description: false)
  end

  def display_data
    data.group_variants.map do |variant|
      [variant,
       data.trial_size(variant),
       data.conversions_count(variant),
       display_statistics(variant)]
    end
  end

  def display_statistics(variant)
    percents = Hash[data.variant_percents]
    percentage = (percents[variant] * 100).round(3)
    standard_error = (data.standard_error(variant) * 100).round(3)

    "Variant #{variant}: #{percentage}% +/- #{standard_error}%"
  end

  def display_favored_data
    puts "\nFinal Analysis:"
    puts @data.favored_variant
  end
end

analyzer = SplitTestAnalyzer.new('data/test_data_favors_a.json')
analyzer.display_favored_data

analyzer = SplitTestAnalyzer.new('data/test_data_favors_b.json')
analyzer.display_favored_data

analyzer = SplitTestAnalyzer.new('data/prod_data.json')
analyzer.display_favored_data
