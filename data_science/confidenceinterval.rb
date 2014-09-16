require_relative "./binomialdatagroup"

class UnsupportedError < RuntimeError; end

class ConfidenceInterval < BinomialDataGroup
  def initialize(params)
    super
    @confidence_level = params[:confidence_level]
    raise_unsupported_error unless @confidence_level == 0.95
  end

  def raise_unsupported_error
    fail UnsupportedError, "We're sorry! only confidence levels of 0.95 are currently supported" \
        "goto 'https://github.com/johnmcconnell/leveluprails/data_science' to add support."
  end

  def standard_deviation
    (success_percent * fail_percent / count)**0.5
  end

  def low_point
    success_percent - interval_weight * standard_deviation
  end

  def high_point
    success_percent + interval_weight * standard_deviation
  end

  def interval_weight
    1.96
  end

  def to_s
    sprintf("Group '%s', low '%3f', mean '%3f', high '%3f'", @id, low_point, @probability, high_point)
  end
end
