class UnsupportedError < RuntimeError; end

class ConfidenceInterval
  def initialize(params)
    @probability = params[:probability_of_success]
    @size = params[:observation_size]
    @confidence_level = params[:confidence_level]
    raise_unsupported_error unless @confidence_level == 0.95
  end

  def raise_unsupported_error
    fail UnsupportedError, "We're sorry! only confidence levels of 0.95 are currently supported" \
        "goto 'https://github.com/johnmcconnell/leveluprails/data_science' to add support."
  end

  def standard_deviation
    (@probability * (1 - @probability) / @size)**0.5
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
end
