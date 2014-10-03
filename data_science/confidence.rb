require_relative 'interval'
require_relative 'observation'
require_relative 'bernoulli'
require_relative 'chi_square'
require 'colorize'

class Confidence
  FLOAT_PRECISION_ERROR = 1e-10

  def initialize
    @observations = {}
  end

  def add(observation)
    subject = observation.subject
    create_subject(subject) unless @observations.key?(subject)
    @observations[subject].update(observation.success)
  end

  def subjects
    @observations.keys
  end

  def interval(subject)
    Interval.new(bernoulli(subject))
  end

  def bernoulli(subject)
    @observations[subject] || Bernoulli.new
  end

  def has_distinct_means?
    chi_square.has_rejected_null_hypothesis?
  end

  def max_subject
    max = @observations.select { |_, bernoulli| has_max_conversion?(bernoulli) }
    return '' if max.empty?
    max.keys.first
  end

  def max_conversion
    max_value = @observations.values.map { |bernoulli| bernoulli.p }.max
    max_value || -1
  end

  def is_max?(subject)
    subject == max_subject
  end

  def chi_square_value
    chi_square.value
  end

  def chi_square_significance
    chi_square.significance
  end

  private

  def create_subject(subject)
    @observations[subject] = Bernoulli.new
  end

  def chi_square
    result = ChiSquare.new
    @observations.each_value { |bernoulli| result.add(bernoulli) }
    result
  end

  def has_max_conversion?(bernoulli)
    bernoulli.p >= max_conversion - FLOAT_PRECISION_ERROR
  end
end
