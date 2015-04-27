require_relative '../cohort'

require 'json'

describe "let" do
  cohort_name = :A
  sample_size = 72
  num_conversions = 5
  conversion_rate = num_conversions.to_f/sample_size
  std_dev = Math.sqrt(conversion_rate*(1-conversion_rate)/sample_size)
  confidence_95pct = 1.96*std_dev

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
        expect(@cohort.name).to(eql(cohort_name))
      end
    end

    describe("#sample_size") do
      it "returns the size of the cohort" do
        expect(@cohort.sample_size).to(eql(sample_size))
      end
    end

    describe("#num_conversions") do
      it "returns the number of successes" do
        expect(@cohort.num_conversions).to(eql(num_conversions))
      end
    end

    it "returns the conversion rate for this cohort" do
      expect(@cohort.conversion_rate).to(eql(conversion_rate))
    end

    it "returns the standard deviation for this cohort" do
      expect(@cohort.std_dev).to(eql(std_dev))
    end

    it "returns the 95% confidence level for this cohort" do
      confidence_interval = []
      confidence_interval.push(@cohort.conversion_rate - confidence_95pct)
      confidence_interval.push(@cohort.conversion_rate + confidence_95pct)
      expect(@cohort.compute_confidence_interval_95pct).to(eql(confidence_interval))
    end
  end
end
