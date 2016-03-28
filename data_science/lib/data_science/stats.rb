module DataScience
  class Stats
    def initialize(data)
      @data = data
      @analyzer = Analyzer.new(data)
      @output = { sample_size: sample_size,
                  conversion_rate: conversion_rate,
                  p_value: p_value,
                  different: different }
    end
    
    def to_s
      @output.values.join("\n")
    end
    
    private
    
    def sample_size
      cohorts.inject([]) do |memo, cohort|
        memo << "Cohort #{cohort} Sample Size: #{@data.sample_size(cohort)}"
      end
    end
    
    def conversion_rate
      interval = 0.95
      cohorts.inject([]) do |memo, cohort|
        memo << "Cohort #{cohort} Conversion Rate: " \
        "#{@analyzer.conversion_rate(cohort)}\n" \
        "Cohort #{cohort} Conversion Rate Error Bar: " \
        "#{@analyzer.conversion_rate_error_bar(cohort, interval)}"
      end
    end
    
    def p_value
      "p-value: #{@analyzer.p_value}"
    end
    
    def different
      "The results are" \
      "#{@analyzer.different? ? '' : ' not'} statistically " \
      "significantly different."
    end
    
    def cohorts
      @data.data.map { |entry| entry.cohort }.uniq.sort
    end
  end
end