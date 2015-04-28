require_relative '../cohort'

COHORT_NAME = :A
SAMPLE_SIZE = 72
NUM_CONVERSIONS = 5
CONVERSION_RATE = 0.06944444444444445
STD_DEV =  0.029958747929501817
CONFIDENCE_95PCT = 0.05871914594182356

describe Cohort do
  let(:cohort) { Cohort.new(COHORT_NAME, SAMPLE_SIZE, NUM_CONVERSIONS) }

  describe("#name") do
    it "returns the correct cohort name" do
      expect(cohort.name).to(eql(COHORT_NAME))
    end
  end

  describe("#sample_size") do
    it "returns the size of the cohort" do
      expect(cohort.sample_size).to(eql(SAMPLE_SIZE))
    end
  end

  describe("#num_conversions") do
    it "returns the number of successes" do
      expect(cohort.num_conversions).to(eql(NUM_CONVERSIONS))
    end
  end

  it "returns the conversion rate for this cohort" do
    expect(cohort.conversion_rate).to(eql(CONVERSION_RATE))
  end

  it "returns the standard deviation for this cohort" do
    expect(cohort.std_dev).to(eql(STD_DEV))
  end

  it "returns the 95% confidence level for this cohort" do
    confidence_interval = []
    confidence_interval.push(CONVERSION_RATE - CONFIDENCE_95PCT)
    confidence_interval.push(CONVERSION_RATE + CONFIDENCE_95PCT)
    expect(cohort.compute_confidence_interval_95pct).to(eql(confidence_interval))
  end
end
