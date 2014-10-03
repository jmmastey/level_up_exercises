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
    return 0.0 if @bernoullis.empty?
    @bernoullis.map { |b| component(b) }.inject(:+)
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
    bernoulli.chi_component(global_estimate)
  end

  def deg_of_freedom
    return 1 if @bernoullis.count < 2
    @bernoullis.count - 1
  end
end
