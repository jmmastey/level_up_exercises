require_relative "./binomial_data_group"

class UnsupportedError < RuntimeError; end

class ConfidenceInterval
  def initialize(args)
    @success_count = args[:success_count]
    @fail_count = args[:fail_count]
    @count = @success_count + @fail_count
    @confidence_level = args[:confidence_level]
    raise_unsupported_error unless @confidence_level == 0.95
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
    format("(low '%3f%%', mean '%3f%%', high '%3f%%')",
           100 * low_percent, 100 * success_percent, 100 * high_percent)
  end

  private

  def raise_unsupported_error
    fail UnsupportedError, unsupported_message
  end

  def unsupported_message
    "We're sorry! only confidence levels of 0.95 are currently supported goto" \
    "'https://github.com/johnmcconnell/leveluprails/data_science' to add " \
    "support."
  end
end
