require "spec_helper"

require_relative "../cohort_collection.rb"

describe CohortCollection do
  let(:cohort_collection) do
    cohort_a = Cohort.new('A', 100, 200)
    cohort_b = Cohort.new('B',120, 60)

    CohortCollection.new([cohort_a, cohort_b])
  end

  context "#initialize" do
    it "raises an error when no initialization parameter given" do
      expect { CohortCollection.new }.to raise_error(ArgumentError)
    end
  end

  context "when initialized properly" do
    it "calculates the total sample size for cohorts" do
      expect(cohort_collection.sum).to be(480)
    end

    it "calculates the total failures for cohorts" do
      expect(cohort_collection.sum_failures).to be(260)
    end

    it "calculates the total successes for cohorts" do
      expect(cohort_collection.sum_successes).to be(220)
    end

    it "calculates the chi-squared value" do
      expect(cohort_collection.chi_squared).to be_within(10e-6).of(50.34965035)
    end

    it "decides the leader in conversion" do
      expect(cohort_collection.leader).to eq('B')
    end

    it "displays proper results" do
      result = <<-eos.gsub(/^[\s\t]*/, '').chomp
        A | samples:   300, success ratio: 33.33%, 95% confidence interval: (28.00% - 38.67%)
        B | samples:   180, success ratio: 66.67%, 95% confidence interval: (59.78% - 73.55%)
      eos

      expect(cohort_collection.to_s).to eq(result)
    end
  end
end
