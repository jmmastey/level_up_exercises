require_relative 'bernoulli'
require 'statistics2'

class ChiSquare
  SIGNIFICANCE_CUTOFF = 0.95

  def initialize
    @bernoullis = []
  end

  def add(bernoulli)
    @bernoullis << bernoulli
  end

  def value
    @bernoullis.inject(0.0) { |sum, bernoulli| sum + component(bernoulli) }
  end

  def significance
    Statistics2.chi2dist(deg_of_freedom, value)
  end

  def has_rejected_null_hypothesis?
    significance > SIGNIFICANCE_CUTOFF
  end

  private

  def global_estimate
    total = Bernoulli.new
    @bernoullis.each { |bernoulli| total.accumulate(bernoulli) }
    total.p
  end

  def component(bernoulli)
    success_component(bernoulli) + failure_component(bernoulli)
  end

  def success_component(bernoulli)
    estimated = global_estimate * bernoulli.n
    observed = bernoulli.successes
    numerator = (observed - estimated)**2
    SafeMath.divide(numerator, estimated)
  end

  def failure_component(bernoulli)
    estimated = (1.0 - global_estimate) * bernoulli.n
    observed = bernoulli.failures
    numerator = (observed - estimated)**2
    SafeMath.divide(numerator, estimated)
  end

  def deg_of_freedom
    return 1 if @bernoullis.count < 2
    @bernoullis.count - 1
  end
end
