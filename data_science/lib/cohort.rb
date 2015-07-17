require 'abanalyzer'

class Cohort
  attr_accessor :name, :size, :conversion_count
  attr_reader :conversion_rate_interval

  def initialize(name: nil, size: 0, conversion_count: 0)
    @name = name
    @size = size
    @conversion_count = conversion_count
    @conversion_rate_interval = calculate_conversion_rate_interval
    @confidence_of_significance = nil
  end

  def confidence_of_significance
    @confidence_of_significance ||= calculate_significance
  end

  def calculate_conversion_rate_interval
    return 0 if size == 0
    interval_confidence = 0.95
    ABAnalyzer.confidence_interval(conversion_count, size, interval_confidence)
  end

  def rate_min
    conversion_rate_interval[0]
  end

  def rate_max
    conversion_rate_interval[1]
  end

  def better_than_random?
    estimate = (rate_min + rate_max) / 2
    estimate > 0.5
  end

  def calculate_significance
    return 0 if size == 0
    cohort = { yes: conversion_count, no: size - conversion_count }
    fake_random = { yes: size / 2, no: size / 2 }
    test = ABAnalyzer::ABTest.new(name => cohort, :random => fake_random)
    p = test.chisquare_p
    p_to_percentage(p)
  end

  def p_to_percentage(p)
    (1 - p) * 100
  end

  def significant?
    significance_level = 95.0
    confidence_of_significance >= significance_level
  end

  def interesting?
    better_than_random? && significant?
  end
end
