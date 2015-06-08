require 'import_data'
require 'abanalyzer'

class ConversionCalculator
  GROUP_NAME = 'cohort'
  RESULT_NAME = 'result'
  attr_reader :data

  def initialize(data)
    @data = data
    values = {}
    values[:agroup] =
      { converted: conversion_num('A'), unconverted: non_conversion_num('A') }
    values[:bgroup] =
      { converted: conversion_num('B'), unconverted: non_conversion_num('B') }
    @analyzer = ABAnalyzer::ABTest.new(values)
  end

  def sample_size(group)
    data.count { |item| item[GROUP_NAME] == group }
  end

  def conversion_num(group)
    group_data = data.select { |item| item[GROUP_NAME] == group }
    group_data.count { |item| item[RESULT_NAME] == 1 }
  end

  def non_conversion_num(group)
    group_data = data.select { |item| item[GROUP_NAME] == group }
    group_data.count { |item| item[RESULT_NAME] == 0 }
  end

  def conversion_rate(group)
    ABAnalyzer.confidence_interval(conversion_num(group), sample_size(group), 0.95)
  end

  def chi_square
    @analyzer.chisquare_score
  end

  def different?
    @analyzer.different?
  end
end
