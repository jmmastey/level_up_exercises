require 'abanalyzer'

class Cohort
  attr_reader :conversion_rate
  attr_reader :error_bars
  attr_accessor :no
  attr_accessor :yes

  CONFIDENCE_INTERVAL = 0.95

  class InvalidResultError < StandardError
    def initialize(result = nil)
      @result = result
    end

    def message
      "Unexpected result: " + value + " (0 or 1 are the accepted values)"
    end
  end

  def initialize
    @no = 0
    @yes = 0
  end

  def add_sample_result(result)
    unless [0, 1].include?(result)
      error = InvalidResultError.new(result)
      raise error
    end
    @no += 1 if result == 0
    @yes += 1 if result == 1
    generate_results
  end

  private

  def generate_results
    total = @no + @yes
    @error_bars = ABAnalyzer.confidence_interval(@yes.to_f, total.to_f, CONFIDENCE_INTERVAL)
    @conversion_rate = (@yes.to_f / total.to_f).round(10)
  end
end
