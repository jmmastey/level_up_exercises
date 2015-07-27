require 'spec_helper'

describe DataLoader do
  let(:filename) { "test_data.json" }
  let(:nothing_loaded) { DataLoader.load_json("doesnt_exist.json") }
  let(:cohort_data) { DataLoader.parse_json(filename) }
  let(:cohorts) { DataLoader.load_json(filename) }

  describe "#load_json" do
    it "returns empty hash when passed a nonexistent file", sad: true do
      expect(nothing_loaded.size).to eq(0)
    end

    it "loads json and returns a dictionary of cohorts", happy: true do
      expect(cohorts.size).to eq(2)
      expect(cohorts['A']).to be_a(Cohort)
      expect(cohorts['B']).to be_a(Cohort)
    end
  end

  describe "#parse_json" do
    it "parses json and returns a dictionary of cohort data", happy: true do
      expect(cohort_data.size).to eq(2)
      expect(cohort_data['A']).to be_a(Array)
      expect(cohort_data['A'].size).to eq(30)
      expect(cohort_data['B']).to be_a(Array)
      expect(cohort_data['B'].size).to eq(30)
    end
  end
end
