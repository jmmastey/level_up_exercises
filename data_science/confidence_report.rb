require_relative 'confidence'
require 'colorize'

class ConfidenceReport
  def initialize(confidence)
    @confidence = confidence
  end

  def to_s
    result = display_table
    result += "\nMax-Conversion: ".yellow + @confidence.max_subject
    result += "\nChi-Square-Value: ".yellow + chi_square_value_msg
    result += "\nChi-Square-Significance: ".yellow + chi_square_significance_msg
    result += "\nChi-Square-Test: ".yellow + distinction_msg + "\n"
  end

  private

  def chi_square_value_msg
    sprintf('%0.4f', @confidence.chi_square_value)
  end

  def chi_square_significance_msg
    sprintf('%0.4f', @confidence.chi_square_significance)
  end

  def distinction_msg
    if @confidence.has_distinct_means?
      'Means are distinct'.green
    else
      'Means are NOT distinct'.blue
    end
  end

  def display_table
    result = underline(display_table_header).yellow
    result += display_table_body
  end

  def underline(str)
    str + "\n" + "-" * str.length + "\n"
  end

  def display_table_header
    sprintf('%-7s %5s %5s %7s %7s %7s', 'Subject', 'Count', 'Convs', 'Estim', 'Lower', 'Upper')
  end

  def display_table_body
    body = ''
    @confidence.subjects.each do |subject|
      body += display_subject(subject) + max_arrow_indicator(subject) + "\n"
    end
    body
  end

  def display_subject(subject)
    bern = @confidence.bernoulli(subject)
    inter = @confidence.interval(subject)
    sprintf('%-7s %5d %5d %7.4f %7.4f %7.4f', subject, bern.n, bern.successes, bern.p, inter.lower, inter.upper)
  end

  def max_arrow_indicator(subject)
    return ' <== '.light_blue + 'Max'.yellow if @confidence.is_max?(subject)
    ''
  end

end
