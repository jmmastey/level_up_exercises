require_relative '../bernoulli'

def create_bernoulli(successes, failures)
  bernoulli = Bernoulli.new
  successes.times { bernoulli.update(true)  }
  failures.times { bernoulli.update(false) }
  bernoulli
end

def an_angstrom
  1e-10
end

