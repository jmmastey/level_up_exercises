require_relative 'data_science'
require_relative 'data_loader'

describe DataLoader do

  describe "optimizer loading" do
    it "loads data" do
      optimizer = Optimizer.new [
        {:cohort => "A", :result => 1}, 
        {:cohort => "A", :result => 1}
      ]
      expect(optimizer.data[:A][:successes]).to eq(2)
    end

    it "loads from filename" do
      optimizer = Optimizer.new "data_export_2014_06_20_15_59_02.json"
      expect(optimizer.data.length).to be > 1
    end
  end

  describe "data loader loading" do
    it "loads from filename" do
      data = DataLoader.load_data("data_export_2014_06_20_15_59_02.json")
      expect(data.length).to be > 1
    end
  end

  it "loads data" do
    data = DataLoader.load_data([
      {:cohort => "A", :result => 1}, 
      {:cohort => "A", :result => 1}
    ])
    expect(data[:A][:successes]).to eq(2)

  end
end