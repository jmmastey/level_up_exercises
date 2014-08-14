# File experiment.rb
class Experiment
  attr_accessor :confidence

  def initialize(confidence=95.0)
    # self.cohorts = cohorts
    self.confidence = confidence.to_f / 100.0
  end

  def standard_error(conversion_rate, visits)
    p = conversion_rate.to_f
    n = visits.to_f
    Math.sqrt(p * (1-p) / n )
  end

  def z_score(two_tailed=false)
    alpha = 1.0-self.confidence
    1.0 - (0.5*alpha)
  end

  def chi_square_formula(visits_a, visits_b, conversion_a, conversion_b)
    numerator = ( visits_a * conversion_b - visits_b * conversion_a )**2 * ( visits_a + visits_b + conversion_a + conversion_b )
    denominator = ( visits_a + visits_b ) * ( visits_a + conversion_a ) * ( visits_b + conversion_b ) * ( conversion_a + conversion_b )
    result = numerator / denominator.to_f
    result.round(3)
  end

  # standard normal cumulative distribution function
  def cdf(z_score)
    (0.5 * (1.0 + Math.erf((z_score*1.0)/Math.sqrt(2))))
  end

  # inverse standard normal cumulative distribution function
  def cdf_inverse(confidence)
    a = [0, -3.969683028665376e+01, 2.209460984245205e+02, -2.759285104469687e+02, 1.383577518672690e+02, -3.066479806614716e+01, 2.506628277459239e+00]
    b = [0, -5.447609879822406e+01, 1.615858368580409e+02, -1.556989798598866e+02, 6.680131188771972e+01, -1.328068155288572e+01]
    c = [0, -7.784894002430293e-03, -3.223964580411365e-01, -2.400758277161838e+00, -2.549732539343734e+00, 4.374664141464968e+00, 2.938163982698783e+00]
    d = [0, 7.784695709041462e-03, 3.224671290700398e-01, 2.445134137142996e+00, 3.754408661907416e+00]
    p_low  = 0.02425
    p_high = 1.0 - p_low

    x = 0.0
    q = 0.0
    if 0.0 < confidence && confidence < p_low
      q = Math.sqrt(-2.0*Math.log(confidence))
      x = (((((c[1]*q+c[2])*q+c[3])*q+c[4])*q+c[5])*q+c[6]) / ((((d[1]*q+d[2])*q+d[3])*q+d[4])*q+1.0)
    elsif p_low <= confidence && confidence <= p_high
      q = confidence - 0.5
      r = q*q
      x = (((((a[1]*r+a[2])*r+a[3])*r+a[4])*r+a[5])*r+a[6])*q / (((((b[1]*r+b[2])*r+b[3])*r+b[4])*r+b[5])*r+1.0)
    elsif p_high < confidence && confidence < 1.0
      q = Math.sqrt(-2.0*Math.log(1.0-confidence))
      x = -(((((c[1]*q+c[2])*q+c[3])*q+c[4])*q+c[5])*q+c[6]) / ((((d[1]*q+d[2])*q+d[3])*q+d[4])*q+1.0)
    end
    pi = Math::PI
    if 0 < confidence && confidence < 1
      e = 0.5 * Math.erfc(-x/Math.sqrt(2.0)) - confidence
      u = e * Math.sqrt(2.0*pi) * Math.exp((x**2.0)/2.0)
      x = x - u/(1.0 + x*u/2.0)
    end
    x
  end
end