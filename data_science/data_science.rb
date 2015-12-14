require "abanalyzer"

class DataScience
  attr_accessor :data

  COHORTS = %w(A B)

  def initialize(data)
    @data = data
    @analyzer = ABAnalyzer::ABTest.new(build_values)
  end

  def significant?
    @analyzer.different?
  end

  def count(hash)
    @data.count do |obj|
      hash.all? { |k, v| obj[k] == v }
    end
  end

  def sample_size
    COHORTS.each_with_object("Total" => @data.length) do |cohort, results|
      results[cohort] = count("cohort" => cohort)
    end
  end

  def conversions
    COHORTS.each_with_object({}) do |cohort, results|
      results[cohort] = count("cohort" => cohort, "result" => 1)
    end
  end

  def confidence
    COHORTS.each_with_object({}) do |cohort, results|
      success  = count("cohort" => cohort, "result" => 1)
      trials = count("cohort" => cohort)
      results[cohort] = ABAnalyzer.confidence_interval(success, trials, 0.95)
    end
  end

  def chi_square
    [@analyzer.chisquare_score, @analyzer.chisquare_p]
  end

  private

  def build_values
    { agroup: build_values_for("A"), bgroup: build_values_for("B") }
  end

  def build_values_for(cohort)
    { success: count("cohort" => cohort, "result" => 1),
      failure: count("cohort" => cohort, "result" => 0) }
  end
end
