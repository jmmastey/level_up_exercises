require "net/http"
require "json"

class Fraction
  attr_accessor :num, :den

  def initialize(numerator, denominator)
    @num = numerator
    @den = denominator
    validate
  end

  def +(rhs)
    raise "Right-hand-side of + must be a Fraction" unless rhs.is_a? Fraction
    num = @num * rhs.den + @den * rhs.num
    den = @den * rhs.den
    Fraction.new(num, den)
  end

  def to_s
    "#{num}/#{den}"
  end

  def from_json(body)
    parsed = JSON.parse(body)
    @num = parsed["num"]
    @den = parsed["den"]
  end

  def load(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    from_json(response.body)
  end

  private

  def validate
    raise "Can't have zero denominator" if @den == 0
    raise "Numerator miust be an integer" unless @num.is_a? Integer
    raise "Denominator miust be an integer" unless @den.is_a? Integer
  end

  def normalize
    make_denominator_positive
    reduce_fraction
  end

  def reduce_fraction
    divisor = @num.abs.gcd(@den)
    @num /= divisor
    @den /= divisor
    @den = 1 if @num == 0
  end

  def make_denominator_positive
    return if @den > 0
    @num = -@num
    @den = -@den
  end
end
