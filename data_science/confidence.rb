require_relative 'interval'
require_relative 'observation'
require_relative 'bernoulli'
require_relative 'chi_square'
require 'colorize'

class Confidence
  def initialize
    @observations = {}
  end

  def add(observation)
    subject = observation.subject
    create_subject(subject) unless @observations.key?(subject)
    @observations[subject].update(observation.success)
  end

  def subjects
    @observations.keys
  end

  def interval(subject)
    Interval.new(bernoulli(subject))
  end

  def has_distinct_means?
    chi_square.has_rejected_null_hypothesis?
  end

  def max_conversion
    max_value = @observations.values.map { |bernoulli| bernoulli.p }.max
    max_value || -1
  end

  def max_subject
    max = @observations.select { |_, bernoulli| has_max_conversion?(bernoulli) }
    return '' if max.empty?
    max.keys.first
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
    result += "\nMax-Conversion: ".yellow + max_subject
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
    return ' <== '.light_blue + 'Max'.yellow if subject == max_subject
    ''
  end

  def underline(str)
    str + "\n" + "-" * str.length + "\n"
  end

  def display_table_header
    sprintf('%-7s %5s %5s %7s %7s %7s', 'Subject', 'Count', 'Convs', 'Estim', 'Lower', 'Upper')
  end

  def display_table_body
    body = ''
    @observations.each_key do |subject|
      body += display_subject(subject) + max_arrow_indicator(subject) + "\n"
    end
    body
  end

  def display_subject(subject)
    bern = bernoulli(subject)
    inter = interval(subject)
    sprintf('%-7s %5d %5d %7.4f %7.4f %7.4f', subject, bern.n, bern.successes, bern.p, inter.lower, inter.upper)
  end

  def distinction_msg
    if has_distinct_means?
      'Means are distinct'.green
    else
      'Means are NOT distinct'.blue
    end
  end

  def chi_square_value_msg
    sprintf('%0.4f', chi_square.value)
  end

  def chi_square_significance_msg
    sprintf('%0.4f', chi_square.significance)
  end

  def create_subject(subject)
    @observations[subject] = Bernoulli.new
  end

  def bernoulli(subject)
    @observations[subject] || Bernoulli.new
  end

  def chi_square
    result = ChiSquare.new
    @observations.each_value { |bernoulli| result.add(bernoulli) }
    result
  end

  def has_max_conversion?(bernoulli)
    bernoulli.p >= max_conversion - 1e-10
  end
end
