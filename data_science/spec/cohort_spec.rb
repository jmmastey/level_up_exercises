require 'spec_helper'

describe Cohort do
  let(:filename) { "test_data.json" }
  let(:data) { JSON.parse(File.read(filename)) }
  let(:cohort_name) { "A" }
  let(:cohort_data) do 
    data.select { |d| d["cohort"] == cohort_name }.map { |d| d["result"] }
  end
  let(:cohort) { Cohort.new(cohort_name, cohort_data) }

  describe "#initialize" do
    it "takes two parameters and returns a Cohort object" do
      expect(cohort).to be_a(Cohort)
      expect(cohort.name).to eq("A")
      expect(cohort.sample_size).to eq(30)
    end
  end
end