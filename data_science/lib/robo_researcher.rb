require_relative 'data_set'
require_relative 'data_reader'
require_relative 'cohort'

class RoboResearcher
  attr_accessor :cohorts
  attr_reader :data_file, :data

  def initialize(data_file: nil)
    @data_file = data_file
    @cohorts = {}
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
      @cohorts[name] = create_cohort(name)
    end
  end

  def create_cohort(name)
    size = data.count(cohort: name)
    conversion_count = data.count(cohort: name, result: 1)
    Cohort.new(name: name, size: size, conversion_count: conversion_count)
  end

  def cohort(name)
    cohorts[name] = create_cohort(name) unless cohorts.key?(name)
    cohorts[name]
  end

  def sample_size
    return 0 if data.nil?
    data.count(:all)
  end

  def conclude
    best = best_cohorts
    cohort_names = best.collect(&:name)
    names = cohort_names.join(" and ")
    to_be = best.length > 1 ? "are" : "is"
    negation = best[0].interesting? ? "" : " NOT"
    "Cohort #{names} #{to_be}#{negation} significantly better than random."
  end

  def best_cohorts
    just_cohorts = cohorts.values
    one_best = just_cohorts.max_by(&:rate_min)
    just_cohorts.find_all { |cohort| cohort.rate_min == one_best.rate_min }
  end

  def details
    cohorts
  end
end
