require 'abanalyzer'

class Cohort
  attr_accessor :name, :size, :conversion_count
  attr_reader :conversion_rate_interval

  def initialize(name: nil, size: 0, conversion_count: 0)
    @name = name
    @size = size
    @conversion_count = conversion_count
    @conversion_rate_interval = calculate_conversion_rate_interval
  end

  def calculate_conversion_rate_interval
    return 0 if size == 0
    interval_confidence = 0.95
    ABAnalyzer.confidence_interval(conversion_count, size, interval_confidence)
  end

  def better_than?(other)
    interval_midpoint > other.interval_midpoint
  end

  def interval_midpoint
    (rate_min + rate_max) / 2
  end

  def rate_min
    conversion_rate_interval[0]
  end

  def rate_max
    conversion_rate_interval[1]
  end

  def significance_of_difference(other)
    cohort = { yes: conversion_count, no: size - conversion_count }
    other_cohort = { yes: other.conversion_count,
                     no: other.size - other.conversion_count }
    test = ABAnalyzer::ABTest.new(name => cohort, other.name => other_cohort)
    p = test.chisquare_p
    p_to_percentage(p)
  end

  def p_to_percentage(p)
    (1 - p) * 100
  end

  def to_s
    "#{readable_basic_data}  #{readable_conversion_rate}"
  end

  def readable_basic_data
    string = "Cohort #{name} contains #{size} samples with #{conversion_count} "
    string << "conversions."
  end

  def readable_conversion_rate
    string = "The conversion rate is #{rate_min_percent}% - "
    string << "#{rate_max_percent}% with a 95% confidence."
  end

  def rate_min_percent
    (rate_min * 100).round
  end

  def rate_max_percent
    uncapped_percentage = (rate_max * 100).round
    [uncapped_percentage, 100].min
  end
end
