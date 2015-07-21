require 'spec_helper'

describe DataLoader do
  let(:filename) { "test_data.json" }
  let(:dummy_class) { Class.new { include DataLoader } }
  let(:loader) { dummy_class.new }
  let(:cohort_data) { loader.parse_json(filename) }
  let(:cohorts) { loader.load_json(filename) }

  describe "#parse_json" do
    it "parses a json file and returns a dictionary of cohort data" do
      expect(cohort_data.size).to eq(2)
      expect(cohort_data['A']).to be_a(Array)
      expect(cohort_data['A'].size).to eq(30)
      expect(cohort_data['B']).to be_a(Array)
      expect(cohort_data['B'].size).to eq(30)
    end
  end

  describe "#load_json" do
    it "loads a json file and returns a dictionary of cohorts" do
      expect(cohorts.size).to eq(2)
      expect(cohorts['A']).to be_a(Cohort)
      expect(cohorts['B']).to be_a(Cohort)
    end
  end
end