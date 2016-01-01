require 'pry'
require 'json'
require 'ABAnalyzer'
require_relative 'cohort_parser'
class DataScience
  attr_reader :conversion, :error_rates
  def initialize(raw_data)
    cohort_data = parse_cohorts_from_raw_data(raw_data)
    @size = cohort_data.size
    @conversion = []
    @hits = []
    @sample_size = []
    cohort_data.each do |k, v|
      @hits << cohort_data[k][:hits]
      @sample_size << cohort_data[k][:attempts]
    end
    @error_rates = []
  end

  def parse_cohorts_from_raw_data(raw_data)
    CohortParser.new(raw_data).convert_to_cohorts
  end

  def calculate_conversion_rate
    @size.times do |i| 
      if(@sample_size[i] < @hits[i])
        raise "Sample size smaller than conversions"
      end
      @conversion[i] =  @hits[i] / @sample_size[i].to_f
    end
    puts @conversion
  end

  def calculate_conversion_rate_with_confidence_level(level)
    @values = []
    @size.times do |i|
      @values << ABAnalyzer.confidence_interval(@hits[i],@sample_size[i], level)
    end
    @values
  end

  def calculate_error_rates
    @values.each do |value|
      @error_rates << (value[1] - value[0])/4
    end
  end
end

#science = DataScience.new([{:hits => 4, :sample_size => 10}, {:hits => 5, :sample_size => 20}])
#science.calculate_conversion_rate
