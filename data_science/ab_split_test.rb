require 'abanalyzer'

class ABSplitTest
  attr_accessor :cohorts, :visits, :conversions

  def initialize(data)
    @cohorts = []
    @visits = {}
    @conversions = {}
    organize_data(data)
  end

  def organize_data(data)
    data.content.each do |row|
      cohort(row)
      conversions[row["cohort"]] ||= 0
      visits[row["cohort"]] ||= 0
      conversion(row)
      visit(row)
    end
  end

  def cohort(row)
    cohorts << row["cohort"] unless cohorts.include? row["cohort"]
  end

  def conversion(row)
    conversions[row["cohort"]] += row["result"]
  end

  def visit(row)
    visits[row["cohort"]] += 1
  end

  def conversion_rate(cohort)
    ABAnalyzer.confidence_interval(conversions[cohort], visits[cohort], 0.95)
  end

  def conversion_hash
    values = {}
    conversions.each do |cohort, value|
      values[cohort] = { converted: value, not_converted: (visits[cohort] - value) }
    end
    values
  end

  def confidence_score
    tester = ABAnalyzer::ABTest.new conversion_hash
    1 - tester.chisquare_p
  end
end
