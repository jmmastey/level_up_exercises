require_relative 'data_science'
require_relative 'data_loader'

describe DataLoader do
  describe "optimizer loading" do
    let (:simple_data) do
      optimizer = Optimizer.new [
        { cohort: "A", result: 1 },
        { cohort: "A", result: 1 },
      ]
    end

    let (:optimizer) do
      Optimizer.new "data_export_2014_06_20_15_59_02.json"
    end

    it "loads data" do
      expect(simple_data.data[:A][:successes]).to eq(2)
    end

    it "loads from filename" do
      expect(optimizer.data.length).to be > 1
    end
  end

  describe "data loader loading" do
    let (:data) do
      DataLoader.load_data("data_export_2014_06_20_15_59_02.json")
    end

    let (:simple_data) do
      data = DataLoader.load_data([
        { cohort: "A", result: 1 },
        { cohort: "A", result: 1 },
      ])
    end

    it "loads from filename" do
      expect(data.length).to be > 1
    end

    it "loads data" do
      expect(simple_data[:A][:successes]).to eq(2)
    end
  end
end
