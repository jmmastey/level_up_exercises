require 'pp'

class Cohort
  attr_reader :name, :attempts, :successes

  def initialize(attributes)
    @name = attributes[:name].to_s
    @attempts = attributes[:attempts].to_i
    @successes = attributes[:successes].to_i
  end

  def conversion_rate
    successes.to_f / attempts.to_f
  end

  def failures
    attempts - successes
  end

  def add_attempt
    @attempts += 1
  end

  def add_success
    @successes += 1
  end
end
