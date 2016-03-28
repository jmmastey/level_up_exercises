module DataScience
  class Analyzer
    require 'abanalyzer'
    
    attr_reader :data
    
    def initialize(data)
      @data = data
    end
    
    def conversion_rate(cohort)
      data.conversion_count(cohort) / data.sample_size(cohort).to_f
    end
    
    def conversion_rate_error_bar(cohort, interval)
      ABAnalyzer.confidence_interval(data.conversion_count(cohort),
                                     data.sample_size(cohort),
                                     interval)
    end
    
    def p_value
      ABAnalyzer::ABTest.new(data.format_for_analyzer).chisquare_p
    end
    
    def different?
      ABAnalyzer::ABTest.new(data.format_for_analyzer).different?
    end
  end
end