require 'abanalyzer'

class DataAnalyzer
  def self.confidence(values)
    tester = ABAnalyzer::ABTest.new values
    confidence_level = 1 - tester.chisquare_p
    confidence_level.round(2)
  end

  def self.conversion_rate(successes, trials, confidence_level = 0.95)
    confidence_interval = ABAnalyzer.confidence_interval(successes, trials, confidence_level)
    conversion_rate = (confidence_interval[0] + confidence_interval[1]) / 2
    error = (confidence_interval[1] - confidence_interval[0]) / 2

    { conversion_rate: conversion_rate.round(2), error: error.round(2) }
  end
end
