require './safe_math'

class Bernoulli
  attr_reader :successes, :failures

  def initialize
    @successes = 0
    @failures = 0
  end

  def update(success)
    if success
      @successes += 1
    else
      @failures += 1
    end
  end

  def accumulate(bernoulli)
    @successes += bernoulli.successes
    @failures += bernoulli.failures
  end

  def n
    @successes + @failures
  end

  def p
    SafeMath.divide(@successes, n)
  end

  def q
    SafeMath.divide(@failures, n)
  end

  # Standard-Error
  def se
    Math.sqrt(SafeMath.divide(p * q, n))
  end

  def to_s
    sprintf("Successes: %5d  Failures: %5d  %6.4f %7.4f", @successes, @failures, p, se)
  end
end
