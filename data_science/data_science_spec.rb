require_relative 'data_science'

fake_data = [
  {"cohort": "A", "result": 1}, 
  {"cohort": "A", "result": 0}, 
  {"cohort": "B", "result": 0},
  {"cohort": "A", "result": 1}, 
  {"cohort": "A", "result": 0}, 
  {"cohort": "B", "result": 0},
  {"cohort": "A", "result": 1}, 
  {"cohort": "A", "result": 0}, 
  {"cohort": "B", "result": 1},
  {"cohort": "A", "result": 1}, 
  {"cohort": "A", "result": 0}, 
  {"cohort": "B", "result": 0},
  {"cohort": "A", "result": 1}, 
  {"cohort": "A", "result": 0}, 
  {"cohort": "B", "result": 0},
  {"cohort": "A", "result": 1}, 
  {"cohort": "A", "result": 0}, 
  {"cohort": "B", "result": 1},
  {"cohort": "A", "result": 0}, 
  {"cohort": "A", "result": 0}, 
  {"cohort": "B", "result": 0},
  {"cohort": "A", "result": 1}, 
  {"cohort": "A", "result": 0}, 
  {"cohort": "B", "result": 0},
  {"cohort": "A", "result": 1}, 
  {"cohort": "A", "result": 0}, 
  {"cohort": "B", "result": 0},
  {"cohort": "A", "result": 1}, 
  {"cohort": "A", "result": 0}, 
  {"cohort": "B", "result": 1},
  {"cohort": "A", "result": 1}, 
  {"cohort": "A", "result": 0}, 
  {"cohort": "B", "result": 0},
  {"cohort": "A", "result": 1}, 
  {"cohort": "A", "result": 0}, 
  {"cohort": "B", "result": 0},
  {"cohort": "A", "result": 1}, 
  {"cohort": "A", "result": 0}, 
  {"cohort": "B", "result": 1},
  {"cohort": "A", "result": 0}, 
  {"cohort": "A", "result": 0}, 
  {"cohort": "B", "result": 0},
]


describe Optimizer do
  before :each do
    @optimizer = Optimizer.new fake_data
  end

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

  it "counts total sample size per cohort" do
    expect(@optimizer.simple_counts[:A][:sample_size]).to eq(28)
    expect(@optimizer.simple_counts[:B][:sample_size]).to eq(14)
  end

  it "counds number of conversions per cohort" do
    expect(@optimizer.simple_counts[:A][:conversions]).to eq(12)
  end

  it "should calculate conversion rates" do
    result = @optimizer.conversion_rates
    expect(result[:A].class).to eq(Array)
    expect(result[:A][0]).to be < result[:A][1]
  end

  it "should do chisquared calculations" do
    expect(@optimizer.result_confidence).to be < 1
  end
end
