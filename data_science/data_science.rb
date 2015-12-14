require 'json'
require 'abanalyzer'
require_relative 'data_loader'

class Optimizer
  attr_accessor :data

  def initialize(initial_data)
    @data = DataLoader.load_data(initial_data)
  end

  def simple_counts
    { A: simple_count_for(:A), B: simple_count_for(:B) }
  end

  def simple_count_for(cohort)
    data = @data[cohort]
    { sample_size: data.values.inject(:+), conversions: data[:successes] }
  end

  def conversion_rates
    { A: conversion_rate_for(:A), B: conversion_rate_for(:B) }
  end

  def conversion_rate_for(cohort)
    counts = simple_count_for(cohort)
    ABAnalyzer.confidence_interval(
      counts[:conversions], counts[:sample_size], 0.95)
  end

  def result_confidence
    tester = ABAnalyzer::ABTest.new(@data)
    tester.chisquare_p
  end
end

optimizer = Optimizer.new("data_export_2014_06_20_15_59_02.json")
puts optimizer.result_confidence
puts optimizer.conversion_rates
puts optimizer.simple_counts