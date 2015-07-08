require_relative '../cohort'

describe Cohort do
  context "basic check" do
    let(:name) { "A" }
    let(:valid_record) { { date: "03/12/2015",
                           cohort: "A",
                           result: 0 } }

    let(:invalid_record) { { date: "03/12/2015",
                             result: 0 } }

    let(:wrong_record) { { date: "03/12/2015",
                           cohort: "B",
                           result: 0 } }

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
    end

    it "validates cohort name" do
      expect { cohort.insert_record(wrong_record) }.to raise_error(NameError)
    end
  end

  context "math check" do
    let(:name) { "B" }
    subject(:cohort) do
      cohort = Cohort.new(name)
      rates = [1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1]
      rates.each do |rate|
        record = { date: "03/12/2015",
                   cohort: "B",
                   result: rate }
        cohort.insert_record(record)
      end
      cohort
    end

    it "accepts multiple records" do
      expect(cohort.records.size).to eq(21)
    end


    it "returns correct conversion ranges" do
      expect(cohort.conversion_rate).to eq([31.02, 73.74])
    end
  end
end
