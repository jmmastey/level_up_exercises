require_relative '../cohort'

require 'json'

describe Cohort do
  before :all do
    file = File.read('smaller_data_set.json')
    all_data = JSON.parse(file)
    pop_data = all_data.select { |record| record["cohort"] == "A" }
    @cohort = Cohort.new(pop_data)
  end

  describe("#new") do
    it "takes a list of dictionaries and returns a Cohort object" do
      expect(@cohort).to(be_an_instance_of(Cohort))
    end
  end

  describe("#name") do
    it "returns the correct cohort name" do
      expect(@cohort.name).to(eql(:A))
    end
  end

  describe("#sample_size") do
    it "returns the size of the cohort" do
      expect(@cohort.sample_size).to(eql(72))
    end
  end

  describe("#num_conversions") do
    it "returns the number of successes" do
      expect(@cohort.num_conversions).to(eql(5))
    end
  end

  it "returns the conversion rate for this cohort" do
    expect(@cohort.compute_conversion_rate).to(eql(5/72.0))
  end

  it "returns the standard deviation for this cohort" do
    expect(@cohort.compute_std_dev).to(eql(0.029958747929501817))
  end

  it "returns the 95% confidence level for this cohort" do
    confidence_interval = []
    confidence_interval.push(@cohort.conversion_rate - 1.96 * @cohort.std_dev)
    confidence_interval.push(@cohort.conversion_rate + 1.96 * @cohort.std_dev)
    expect(@cohort.compute_confidence_interval_95pct).to(eql(confidence_interval))
  end
end
