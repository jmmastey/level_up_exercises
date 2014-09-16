require_relative "./binomial_data_group"

class UnsupportedError < RuntimeError; end

class ConfidenceInterval
  def initialize(params)
    @success_count = params[:success_count]
    @fail_count = params[:fail_count]
    @count = @success_count + @fail_count
    @confidence_level = params[:confidence_level]
    raise_unsupported_error unless @confidence_level == 0.95
  end

  def raise_unsupported_error
    fail UnsupportedError, "We're sorry! only confidence levels of 0.95 are currently supported" \
        "goto 'https://github.com/johnmcconnell/leveluprails/data_science' to add support."
  end

  def standard_deviation
    (success_percent * fail_percent / @count)**0.5
  end

  def low_percent
    success_percent - interval_weight * standard_deviation
  end

  def high_percent
    success_percent + interval_weight * standard_deviation
  end

  def success_percent
    @success_count.to_f / @count
  end

  def fail_percent
    @fail_count.to_f / @count
  end

  def interval_weight
    1.96
  end

  def to_s
    format("Confidence Interval:(low '%3f', mean '%3f', high '%3f')",
      low_percent, success_percent, high_percent)
  end
end
