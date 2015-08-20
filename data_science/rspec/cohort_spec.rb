require_relative '../cohort'

describe Cohort do
  context "basic check" do
    let(:name) { "A" }
    let(:valid_record) { { date: "03/12/2015", cohort: "A", result: 0 } }
    let(:invalid_record) { { date: "03/12/2015", result: 0 } }
    let(:wrong_record) { { date: "03/12/2015", cohort: "B", result: 0 } }

    subject(:cohort) { Cohort.new(name) }

    it "sets the cohort name" do
      expect(cohort.name).to eq("A")
    end

    it "starts with no records" do
      expect(cohort.records).to eq(0)
    end

    it "validates record hashes" do
      expect { cohort.insert_record(invalid_record) }.to raise_error(ArgumentError)
      expect { cohort.insert_record(valid_record) }.to_not raise_error
    end

    it "validates cohort name" do
      expect { cohort.insert_record(wrong_record) }.to raise_error(NameError)
    end
  end

  context "math check" do
    subject(:cohorts) do
      DataScience.new('test.json').cohorts
    end

    it "has the correct number of records" do
      expect(cohorts["A"].records).to eq(29)
      expect(cohorts["B"].records).to eq(30)
    end

    it "returns correct conversion ranges for those records" do
      expect(cohorts["A"].conversion_rate).to match_array([5.95, 35.43])
      expect(cohorts["B"].conversion_rate).to match_array([46.09, 80.58])
    end
  end
end
