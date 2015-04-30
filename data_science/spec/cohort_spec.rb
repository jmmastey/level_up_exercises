require_relative '../cohort'

COHORT_NAME = :A
SAMPLE_SIZE = 72
NUM_CONVERSIONS = 5
NUM_FAILURES = 67
CONVERSION_RATE = 0.06944444444444445
STD_DEV =  0.029958747929501817
CONFIDENCE_95PCT = 0.05871914594182356

describe Cohort do
  let(:cohort) { Cohort.new(COHORT_NAME, SAMPLE_SIZE, NUM_CONVERSIONS) }
  let(:expected_confidence_interval) do
    [CONVERSION_RATE - CONFIDENCE_95PCT,
     CONVERSION_RATE + CONFIDENCE_95PCT]
  end

  describe("#cohort object, which contains info about a single cohort,") do
    it "can return its name to the user" do
      expect(cohort.name).to(eql(COHORT_NAME))
    end

    it "can return the size of the cohort (number of trials) to the user" do
      expect(cohort.sample_size).to(eql(SAMPLE_SIZE))
    end

    it "can return the number of conversions that occurred for that cohort" do
      expect(cohort.num_conversions).to(eql(NUM_CONVERSIONS))
    end

    it "has a method to compute the number of trials that didn't result in a conversion" do
      expect(cohort.compute_failures).to(eql(NUM_FAILURES))
    end

    it "can return the conversion rate for this cohort" do
      expect(cohort.conversion_rate).to(eql(CONVERSION_RATE))
    end

    it "has a method to return the standard deviation of the cohort data set" do
      expect(cohort.std_dev).to(eql(STD_DEV))
    end

    it "has a method to returns the interval in which we are 95% confident that the conversion rate will be for this cohort" do
      expect(cohort.confidence_interval_95pct).to(eql(expected_confidence_interval))
    end
  end
end
