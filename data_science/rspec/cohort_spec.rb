require_relative '../cohort'

describe Cohort do
  context "basic check" do
    let(:name) { "A" }
    let(:valid_record) do
      { date: "03/12/2015",
        cohort: "A",
        result: 0 }
    end

    let(:invalid_record) do
      { date: "03/12/2015",
        result: 0 }
    end

    let(:wrong_record) do
      { date: "03/12/2015",
        cohort: "B",
        result: 0 }
    end

    subject(:cohort) { Cohort.new(name) }

    it "creates a cohort object" do
      expect(cohort).to_not be_nil
    end

    it "sets the cohort name" do
      expect(cohort.name).to eq("A")
    end

    it "starts with no records" do
      expect(cohort.records.size).to eq(0)
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
      expect(cohorts["A"].records.size).to eq(29)
      expect(cohorts["B"].records.size).to eq(30)
    end

    it "returns correct conversion ranges for those records" do
      expect(cohorts["A"].conversion_rate).to eq([5.95, 35.43])
      expect(cohorts["B"].conversion_rate).to eq([46.09, 80.58])
    end
  end
end
