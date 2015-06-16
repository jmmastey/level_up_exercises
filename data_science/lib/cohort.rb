require 'abanalyzer'

class Cohort
  attr_reader :conversion_rate, :error_bars, :sample_size,
    :conversions, :non_conversions, :name, :confidence_interval,
    :data

  REQUIRED_CONFIDENCE = 0.95

  def initialize(args)
    @data = args
    parse_args(args)
    @sample_size = sample_size
    @conversion_rate = calculate_conversion_rate
    @confidence_interval = calculate_confidence_interval
  end

  def parse_args(args)
    args.each do |key, _value|
      @name = key
      @conversions = args[key].values.first
      @non_conversions = args[key].values.last
    end
  end

  def sample_size
    conversions + non_conversions
  end

  def calculate_conversion_rate
    (conversions.to_f / sample_size.to_f).round(2)
  end

  def calculate_confidence_interval
    ABAnalyzer.confidence_interval(conversions.to_f, sample_size.to_f, REQUIRED_CONFIDENCE)
  end
end
