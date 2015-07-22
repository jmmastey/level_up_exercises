require_relative 'data_set'
require_relative 'data_reader'
require_relative 'cohort'

class RoboResearcher
  attr_accessor :cohorts
  attr_reader :data_file, :data

  def initialize(data_file: nil)
    @data_file = data_file
    @cohorts = []
    @data = DataSet.new(data: [])
    initialize_from_data_file unless data_file.nil?
  end

  def initialize_from_data_file
    initialize_data
    populate_cohorts
  end

  def initialize_data
    data_points = DataReader.new(data_file).data
    @data = DataSet.new(data: data_points)
  end

  def populate_cohorts
    data.possible_values(:cohort).each do |name|
      @cohorts << create_cohort(name)
    end
  end

  def create_cohort(name)
    size = data.count(cohort: name)
    conversion_count = data.count(cohort: name, result: 1)
    Cohort.new(name: name, size: size, conversion_count: conversion_count)
  end

  def conclude
    significance = cohorts[0].significance_of_difference(cohorts[1])
    if significance < 95.0
      return "There is no significant difference between cohorts."
    else
      conclude_significant(significance)
    end
  end

  def conclude_significant(significance)
    best = cohorts[0].better_than?(cohorts[1]) ? cohorts[0] : cohorts[1]
    sig = shorten_significance(significance)
    string = "Cohort #{best.name} is better with 95% confidence.  The "
    string << "difference is significant with #{sig}% confidence."
  end

  def shorten_significance(significance)
    return 99.99 if significance >= 99.99
    return 99.9 if significance >= 99.9
    return 99 if significance >= 99
    significance.round
  end

  def details
    cohorts.each_with_object([]) do |cohort, info|
      info << cohort.to_s
    end
  end
end
