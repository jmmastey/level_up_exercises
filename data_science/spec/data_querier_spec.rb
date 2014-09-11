require_relative "../data_querier"

describe DataQuerier do
  it "initializes with an array of data entries" do
    DataQuerier.new([DataEntry.new, DataEntry.new])
  end

  it "is an Enumerable" do
    expect(DataQuerier.new).to be_an(Enumerable)
  end

  let(:random_query) do  
    DataQuerier.new([
      DataEntry.new(cohort: "A", result: 0),
      DataEntry.new(cohort: "A", result: 1),
      DataEntry.new(cohort: "A", result: 0),
      DataEntry.new(cohort: "B", result: 1),
      DataEntry.new(cohort: "B", result: 0),
      DataEntry.new(cohort: "A", result: 1),
      DataEntry.new(cohort: "B", result: 0),
      DataEntry.new(cohort: "A", result: 1),
      DataEntry.new(cohort: "B", result: 0),
      DataEntry.new(cohort: "A", result: 0),
    ])
  end

  describe "#count_cohort_views" do
    it "counts the number of views from a cohort" do
      expect(random_query.count_cohort_views("A")).to eq(6)
      expect(random_query.count_cohort_views("B")).to eq(4)
    end
  end

  describe "#count_cohort_conversions" do
    it "counts the number of conversions from a cohort" do
      expect(random_query.count_cohort_conversions("A")).to eq(3)
      expect(random_query.count_cohort_conversions("B")).to eq(1)
    end
  end
end
