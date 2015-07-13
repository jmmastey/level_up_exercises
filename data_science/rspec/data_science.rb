require '../data_science.rb'

describe DataScience do
  before :all do
    data_file = '../data_export_2014_06_20_15_59_02.json'
    @data_science = DataScience.new(data_file)
    @cohort_b = @data_science.cohorts[1]
  end

  it "should have the correct sample size" do
    expect(@data_science.sample_size).to eq(2892)
  end

  it "should have two cohorts" do
    expect(@data_science.cohorts.count).to eq(2)
  end

  it "should report a winner if the chi-square test is significant" do
    expect(@data_science.winner).to eq(@cohort_b)
  end
end
