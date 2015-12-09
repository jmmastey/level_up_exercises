require_relative 'data_science'

describe Optimizer do
  fake_data = [{"cohort": "A", "result": 2}, {"cohort": "A", "result": 4}, {"cohort": "B", "result": 0}]
  before :each do
    @optimizer = Optimizer.new fake_data
  end

  it "loads data" do
    optimizer = Optimizer.new [{:cohort => "A", :result => 1}, {:cohort => "A", :result => 1}]
    expect(optimizer.data[:A][:successes]).to eq(2)
  end

  it "loads from filename" do
    optimizer = Optimizer.new "data_export_2014_06_20_15_59_02.json"
    puts optimizer.data
    expect(optimizer.data.length).to be > 1
  end

  it "counts total sample size per cohort" do

  end

  it "counds number of conversions per cohort" do

  end 
end