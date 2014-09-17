require "./bernoulli"

class Interval
  def initialize(bernoulli)
    @bernoulli = bernoulli
  end

  def midpt
    @bernoulli.p
  end

  def lower(z = 2)
    level(-z)
  end

  def upper(z = 2)
    level(z)
  end

  def level(z)
    midpt + z * @bernoulli.se
  end

  def to_s
    "Est: #{midpt}  Err: #{@bernoulli.se}"
  end

  def display(z = 2)
    sprintf("(%7.4f <--> %7.4f)", lower(z), upper(z))
  end
end
