require "./interval"
require "./observation"
require "./bernoulli"
require "./chi_square"
require "./max"
require "colorize"

class Confidence
  def initialize()
    @observations = {}
  end

  def add(observation)
    subject = observation.subject
    create_subject(subject) unless @observations.has_key?(subject)

    success = observation.success
    @observations[subject].update(success)
  end

  def subjects
    @observations.keys
  end

  def interval(subject)
    Interval.new(bernoulli(subject))
  end

  def has_distinct_means?
    chi_square.has_rejected_null_hyp?
  end

  def chi_square_value_msg
    sprintf("%0.4f", chi_square.value)
  end

  def chi_square_significance_msg
    sprintf("%0.4f", chi_square.significance)
  end

  def get_max_conversion
    max = Max.new
    @observations.each_value { |bernoulli| max << bernoulli.p }
    max.value || -1
  end

  def get_max_subject
    max_subject = ""
    @observations.each_key do |subject|
      max_subject = subject if bernoulli(subject).p >= get_max_conversion - 1e-8
    end
    max_subject
  end

  def to_s
    result = "Confidence\n----------\n"
    @observations.each do |subject, bernoulli| 
      result += "#{subject} => #{bernoulli}\n"
    end
    result
  end

  def report
    result = display_table
    result += "\nMax-Conversion: ".yellow + get_max_subject
    result += "\nChi-Square-Value: ".yellow + chi_square_value_msg
    result += "\nChi-Square-Significance: ".yellow + chi_square_significance_msg
    result += "\nChi-Square-Test: ".yellow + distinction_msg
  end

  private
  def display_table
    result = underline(display_table_header).yellow
    result += display_table_body
  end

  def max_arrow_indicator(subject)
    return " <== ".light_blue + "Max".yellow if subject == get_max_subject
    ""
  end

  def underline(str)
    str + "\n" + "-" * str.length + "\n"
  end

  def display_table_header
    sprintf("%-7s %5s %5s %7s %7s %7s", "Subject", "Count", "Convs", "Estim", "Lower", "Upper")
  end

  def display_table_body
    body = ""
    @observations.each_key do |subject| 
      body += display_subject(subject) + max_arrow_indicator(subject) + "\n"
    end
    body
  end

  def display_subject(subject)
    bern = bernoulli(subject)
    inter = interval(subject)
    sprintf("%-7s %5d %5d %7.4f %7.4f %7.4f", subject, bern.n, bern.successes, bern.p, inter.lower, inter.upper)
  end

  def distinction_msg
    return "Means are distinct".green if has_distinct_means?
    "Means are NOT distinct".blue
  end

  def create_subject(subject)
    @observations[subject] = Bernoulli.new
  end

  def bernoulli(subject)
    if @observations.has_key?(subject)
      @observations[subject]
    else
      Bernoulli.new
    end
  end

  def chi_square
    result = ChiSquare.new
    @observations.each { |subject, bernoulli| result.add(bernoulli) }
    result
  end
end
