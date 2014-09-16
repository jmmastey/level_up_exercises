class UnsupportedError < RuntimeError; end

class ConfidenceInterval
  def initialize(params)
    @success_count = params[:success_count]
    @fail_count = params[:fail_count]
    @confidence_level = params[:confidence_level]
    @id = params[:id]
    raise_unsupported_error unless @confidence_level == 0.95
    @total_count = @success_count + @fail_count
    @probability = @success_count.to_f / (@total_count)
  end

  def raise_unsupported_error
    fail UnsupportedError, "We're sorry! only confidence levels of 0.95 are currently supported" \
        "goto 'https://github.com/johnmcconnell/leveluprails/data_science' to add support."
  end

  def standard_deviation
    (@probability * (1 - @probability) / @total_count)**0.5
  end

  def low_point
    @probability - interval_weight * standard_deviation
  end

  def high_point
    @probability + interval_weight * standard_deviation
  end

  def interval_weight
    1.96
  end

  def to_s
    "Group '%s', low '%3f', mean '%3f', high '%3f'" % [@id, low_point, @probability, high_point]
  end
end
