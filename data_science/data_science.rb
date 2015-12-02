require "abanalyzer"

class DataScience
  attr_accessor :data

  def initialize(data)
    @data = data
    @analyzer = ABAnalyzer::ABTest.new(build_values)
  end

  def significance?
    @analyzer.different?
  end

  def count(hash)
    results = @data.select do |obj|
      hash.all? { |k, v| obj[k] == v }
    end
    results.length
  end

  def sample_size
    results = {}
    results["Total"] = @data.length
    %w(A B).each do |cohort|
      results[cohort] = count("cohort" => cohort)
    end
    results
  end

  def conversions
    results = {}
    %w(A B).each do |cohort|
      results[cohort] = count("cohort" => cohort, "result" => 1)
    end
    results
  end

  def confidence
    results = {}
    %w(A B).each do |cohort|
      success  = count("cohort" => cohort, "result" => 1)
      trials = count("cohort" => cohort)
      results[cohort] = ABAnalyzer.confidence_interval(success, trials, 0.95)
    end
    results
  end

  private

  def build_values
    values = {}
    values[:agroup] = { success: count("cohort" => "A", "result" => 1),
                        failure: count("cohort" => "A", "result" => 0) }
    values[:bgroup] = { success: count("cohort" => "B", "result" => 1),
                        failure: count("cohort" => "B", "result" => 0) }
    values
  end
end
