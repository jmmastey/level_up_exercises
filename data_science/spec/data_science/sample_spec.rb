require 'data_science/sample'
require_relative '../factories'

describe Sample do
  before do
    @sample = Sample.new
    @sample_data = [{"date"=>"2014-03-20", "cohort"=>"B", "result"=>0}, {"date"=>"2014-03-20", "cohort"=>"B", "result"=>0}]
  end

  it 'is instantiated with an empty array of data points' do
    expect(@sample.data_points).to eq([])
  end

  it 'adds a data point to itself' do
    @sample.add_data_to_sample(@sample_data)
    expect(@sample.data_points.size).to eq(2)
  end

  context 'calculate sample statistics' do
    before do
      data_point_1 = build(:data_point, cohort: "A", result: 0)
      @sample.data_points << data_point_1
      data_point_2 = build(:data_point, cohort: "A", result: 0)
      @sample.data_points << data_point_2
      data_point_3 = build(:data_point, cohort: "A", result: 1)
      @sample.data_points << data_point_3
      data_point_4 = build(:data_point, cohort: "A", result: 1)
      @sample.data_points << data_point_4
      data_point_5 = build(:data_point, cohort: "A", result: 1)
      @sample.data_points << data_point_5
      data_point_6 = build(:data_point, cohort: "B", result: 0)
      @sample.data_points << data_point_6
      data_point_7 = build(:data_point, cohort: "B", result: 0)
      @sample.data_points << data_point_7
      data_point_8 = build(:data_point, cohort: "B", result: 0)
      @sample.data_points << data_point_8
      data_point_9 = build(:data_point, cohort: "B", result: 1)
      @sample.data_points << data_point_9
      data_point_10 = build(:data_point, cohort: "B", result: 1)
      @sample.data_points << data_point_10
    end

    it 'calculates the total sample size' do
      expect(@sample.sample_size).to eq(10)
    end

    it 'calculates the number of conversions for the A group' do
      expect(@sample.conversions("A")).to eq(3)
    end

    it 'calculates the number of conversions for the B group' do
      expect(@sample.conversions("B")).to eq(2)
    end

    it 'calculates the cohort size' do
      expect(@sample.cohort_size("A")).to eq(5)
    end

    it 'calculates the conversion rate for the A group' do
      expect(@sample.conversion_rate("A")).to eq(0.6)
    end

    it 'calculates the standard error' do
      expect(@sample.standard_error("A")).to be_within(0.01).of(0.21908)
    end

    it 'calculates the error bars conversion with a 95% confidence for the A group' do
      expect(@sample.error_bars("A")). to be_within(0.001).of(0.42941)
    end
  end
end
