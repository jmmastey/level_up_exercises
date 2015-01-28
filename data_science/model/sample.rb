require './model/datum.rb'
require 'abanalyzer'


module Model
  class Sample
    #because the plural for datum is data
    attr_accessor :data

    #CONFIDENCE VALUE > 95
    CONVERSION_RATE_MULTIPLIER = 1.96

    #DEFAULT FILE
    DEFAULT_SAMPLE_FILE = './source_data.json'

    def initialize(file = DEFAULT_SAMPLE_FILE)
      @data = Datum.process_json(file)
    end

    def total_size
      @data.size
    end

    def cohort_size(cohort)
      @data.select { |datum| datum.cohort == cohort }.size
    end

    def cohort_conversions(cohort)
      @data.select do |datum|
        datum.cohort == cohort && datum.result == 1
      end.size
    end

    def cohort_non_conversions(cohort)
      @data.select do |datum|
        datum.cohort == cohort && datum.result == 0
      end.size
    end

    def conversion_rate(cohort)
      1.0 * cohort_conversions(cohort) / cohort_size(cohort)
    end

    def standard_error(cohort)
      factor = ( 1 - conversion_rate(cohort)) / cohort_size(cohort)
      Math.sqrt(conversion_rate(cohort) * factor)
    end

    def error_bars(cohort)
      (standard_error(cohort) * CONVERSION_RATE_MULTIPLIER) * 100
    end

    # Thanks Paul Haddad for giving me resources (Amazon - Math behind AB testing,
    # https://developer.amazon.com/sdk/ab-testing/reference/ab-math.html
    # https://developer.amazon.com/sdk/ab-testing/reference/how-ab-works.html

    def calculate_confidence_level
      values = Hash.new
      get_cohorts.each do |cohort|
        values[cohort.to_sym] = { :non_conversions => cohort_non_conversions(cohort),
                                  :conversion => cohort_conversions(cohort)
        }
      end
      tester = ABAnalyzer::ABTest.new(values)
      1 - tester.chisquare_p
    end

    def get_cohorts
      cohorts = []
      @data.uniq { |datum| datum.cohort }.each { |d| cohorts << d.cohort }
      cohorts
    end
  end
end
