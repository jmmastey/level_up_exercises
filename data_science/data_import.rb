require 'json'
require './data_analyzer'

class DataImport
  attr_reader :data_hash

  def initialize(file_name = 'data_export_2014_06_20_15_59_02.json')
    data_file = File.read(file_name)
    @data_hash = JSON.parse(data_file)
  end

  def confidence
    DataAnalyzer.confidence(format)
  end

  def conversion_rates
    formatted_data = format
    conversion_rates = {}
    formatted_data.each do |cohort, cohort_data|
      successes = cohort_data[:conversions]
      fails = cohort_data[:fails]
      total = successes + fails
      conversion_rates[cohort.to_sym] = DataAnalyzer.conversion_rate(successes, total)
    end

    conversion_rates
  end

  def format
    formatted_data = {}
    formatted_data[:cohort_a] = { conversions: 0, fails: 0 }
    formatted_data[:cohort_b] = { conversions: 0, fails: 0 }
    @data_hash.each do |entry|
      cohort = "cohort_#{entry['cohort'].downcase}".to_sym
      formatted_data[cohort][:conversions] += 1 if entry['result'] == 1
      formatted_data[cohort][:fails] += 1 if entry['result'] == 0
    end

    formatted_data
  end

  def print_statistics
    format.each do |cohort, stats|
      formatted_cohort = cohort.to_s.split('_').map(&:capitalize).join(' ')
      cohort_conversion = stats[:conversions]
      cohort_fails = stats[:fails]
      cohort_total = cohort_conversion + cohort_fails
      puts "The conversions for #{formatted_cohort} "\
        "is #{cohort_conversion} out of #{cohort_total}"
    end

    conversion_rates.each do |cohort, rates|
      formatted_cohort = cohort.to_s.split('_').map(&:capitalize).join(' ')
      cohort_conversion = rates[:conversion_rate]
      cohort_error = rates[:error]
      puts "The conversion rate for #{formatted_cohort} "\
        "is #{cohort_conversion} +/- #{cohort_error}"
    end

    puts "The confidence level is #{confidence}."
  end
end
