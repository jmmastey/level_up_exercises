require_relative "../data_entry"

describe DataEntry do
  describe ".new" do
    it "can take no parameters" do
      entry = DataEntry.new

      expect(entry).to be_a(DataEntry)
    end

    it "can take a hash of data as a parameter" do
      entry = DataEntry.new(cohort: "A",
                            date: "2014-09-10",
                            result: 1)

      expect(entry.cohort).to eq("A")
      expect(entry.date).to eq("2014-09-10")
      expect(entry.result).to eq(1)
    end
  end

  describe "#conversion?" do
    it "returns true if result is 1" do
      entry = DataEntry.new(result: 1)

      expect(entry).to be_conversion
    end

    it "returns false if result is 0" do
      entry = DataEntry.new(result: 0)

      expect(entry).not_to be_conversion
    end

    it "defaults to false" do
      entry = DataEntry.new

      expect(entry).not_to be_conversion
    end
  end
end
