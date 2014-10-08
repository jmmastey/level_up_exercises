require 'abanalyzer'
require_relative 'datum'

class Dataset
  CONFIDENCE = 1.96
  attr_accessor :results

  def initialize(data)
    @results = data.map { |line| Datum.new(line) }
  end

  def total_sample_size
    @results.length
  end

  def total_in_group(cohort)
    @results.count { |result| result.cohort == cohort }
  end

  def number_of_conversions(cohort)
    @results.count { |result| result.cohort == cohort && result.result == 1 }
  end

  def percentage_of_conversion(cohort)
    (number_of_conversions(cohort).to_f / total_in_group(cohort).to_f)
  end

  def calculate_standard_error(cohort)
    p = percentage_of_conversion(cohort)
    n = total_in_group(cohort)

    ((Math.sqrt(p * (1 - p) / n)) * CONFIDENCE)
  end

  def calculate_probability
    click_a = number_of_conversions('A')
    click_b = number_of_conversions('B')
    groups =
    {
      groupa: { success: click_a, failure: (total_in_group('A') - click_a) },
      groupb: { success: click_b, failure: (total_in_group('B') - click_b) },
    }

    ABAnalyzer::ABTest.new(groups).chisquare_p
  end
end
