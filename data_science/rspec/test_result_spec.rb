require_relative '../test_result'

describe TestResult  do
  context "initialize" do
    cohort = "A"
    date = "2014-05-19"
    result = 1

    test_result = TestResult.new(cohort, date, result)

    it "should initialize with a cohort" do
      expect(test_result.cohort).to equal(cohort)
    end

    it "should initialize with a date" do
      expect(test_result.date).to equal(date)
    end

    it "should initialize with a result" do
      expect(test_result.result).to equal(result)
    end
  end
end
