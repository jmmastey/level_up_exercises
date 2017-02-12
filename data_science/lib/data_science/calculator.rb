require_relative 'Sample'
require 'ABAnalyzer'

class Calculator
  
  def initialize(input)
    @sample_collection = Sample.create_cohort(input)
  end

  def sample_size(cohort)
    @sample_collection.count{|sample| sample.cohort == cohort}
  end

  def sample_conversions(cohort)
    @sample_collection.count{|sample| sample.cohort == cohort && sample.result \
    == 1}
  end

  def conversion_rate(cohort)
    sample_conversions(cohort)/sample_size(cohort).to_f
  end

  def std_dev(cohort)
    rate = conversion_rate(cohort)
    (rate*(1-rate))/(sample_conversions(cohort).to_f)**0.5
  end

  def std_err(cohort)
    std_dev(cohort)/(sample_conversions(cohort)**0.5).to_f
  end

  def err_bar(cohort)
    std_err(cohort)*1.96
  end

  def distribution_limit(cohort)
    rate = conversion_rate(cohort)
    ebar = err_bar(cohort)
    [(rate-ebar).round(3), (rate+ebar).round(3)]
  end

  def leader
    cohorts = []
    @sample_collection.uniq(&:cohort).each do |row|
      cohorts << {:name => row.cohort, :rate => conversion_rate(row.cohort)}
    end
    cohorts.max_by {|_k, v| v} [:name]
  end

  def chi_square
    values = {}
    @sample_collection.uniq(&:cohort).each do |row|
      values[row.cohort] ||= {:success => sample_conversions(row.cohort),
        :failure => (sample_size(row.cohort)-sample_conversions(row.cohort))}
    end
    tester = ABAnalyzer::ABTest.new values
    tester.chisquare_p.round(3)
  end


end
