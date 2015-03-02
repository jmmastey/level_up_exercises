require 'ABAnalyzer'
load 'fileparser.rb'

class DataScience
  attr_accessor :cohorts, :ab_analyzer, :analyzer_data

  def initialize(filename)
    @cohorts = FileParser.parse_data(filename)
  end

  def cohort_count(name)
    @cohorts.count { |cohort| cohort.name == name }
  end

  def conversion_count(name)
    @cohorts.count { |cohort| cohort.name == name && cohort.result == 1 }
  end

  def conversion_miss_count(name)
    @cohorts.count { |cohort| cohort.name == name && cohort.result == 0 }
  end

  def chisqaure_p
    @analyzer_data = {}
    @cohorts.uniq(&:name).each do |row|
      @analyzer_data[row.name] ||=
                                  {
                                    total: cohort_count(row.name),
                                    conversion: conversion_count(row.name)
                                  }
    end
    (1.0 - ABAnalyzer::ABTest.new(@analyzer_data).chisquare_p).round(4)
  end

  def conversion_rate(name)
    (conversion_count(name).to_f / cohort_count(name).to_f).round(4)
  end

  def leader
    leader = []
    @cohorts.uniq(&:name).each do |row|
      leader << { name: row.name, rate: conversion_rate(row.name) }
    end
    leader.max_by { |_k, v| v }[:name]
  end

  def distribution_limit(name)
    r = conversion_rate(name)
    eb = error_bar(name)
    [(r - eb).round(4), (r + eb).round(4)]
  end

  def standard_deviation(name)
    r = conversion_rate(name)
    ((r * (1 -  r)) / conversion_count(name).to_f)**0.5
  end

  def standard_error(name)
    standard_deviation(name) / (conversion_count(name)**0.5).to_f
  end

  def error_bar(name)
    (standard_error(name) * 1.96).round(4)
  end
end
