class StatCalculator

  def stat_calculation(cohorts_data)
    @conversion_rate = conversion_rate(cohorts_data[:success], cohorts_data[:totalno])
    @standard_error = standard_error(@conversion_rate, cohorts_data[:totalno])
    @confidence = confidence(@standard_error, @conversion_rate)
    print_calculated_values
  end

  def conversion_rate(no_of_success, no_of_trials)
    raise ArgumentError, "Number of trials or sucess is nil" if (no_of_success.nil? || no_of_trials.nil?)
    raise ArgumentError, "Number of trials is zero or negative" if no_of_trials <= 0
    raise ArgumentError, "Number of success is more than number of trials" if no_of_success > no_of_trials
    raise ArgumentError, "Number of success is zero or negative" if no_of_success <= 0
    puts "Number of trials #{no_of_trials}"
    puts "Number of success #{no_of_success}"
    (no_of_success/no_of_trials.to_f).round(2)
  end

  def standard_error(conversion_rate, no_of_trials)
    raise ArgumentError, "Conversion rate is zero or negative" if conversion_rate <= 0
    raise ZeroDivisionError, "Number of trials is zero or negative" if no_of_trials <= 0
    raise ArgumentError, "Conversion rate is greater than or equal to 1" if conversion_rate >= 1
    (Math.sqrt(conversion_rate*(1-conversion_rate)/no_of_trials)).round(3)
  end

  def confidence(conversion_rate, standard_error)
    raise ArgumentError, "Conversion rate is zero or negative" if conversion_rate <=0
    raise ArgumentError, "Standard error is zero or negative" if standard_error <=0
    confidence = []
    confidence_low = conversion_rate * 100 + 2 * standard_error
    confidence_high = conversion_rate * 100 - 2 *standard_error
    confidence << confidence_low.round(2)
    confidence << confidence_high.round(2)
    confidence
  end

  def print_calculated_values
    puts "Conversion rate #{@conversion_rate}"
    puts "Standard error #{@standard_error}"
    puts "Confidence  #{@confidence}"
  end
end
