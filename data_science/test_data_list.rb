require 'json'
require_relative 'test_result'
class TestDataList < Array
  def parse(filepath)
    results_hash = {}
    File.open(filepath, "r") do |f|
      results_hash = JSON.load(f)
    end

    results_hash.map do |result|
      push(TestResult.new(result['cohort'], result['date'], result['result']))
    end
  end
end
