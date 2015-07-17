require 'rspec'
require 'json'
require_relative './cohort.rb'

describe Cohort do
  let(:test_file_name) { 'test_data.json' }
  before do
    data = JSON.parse(File.read(test_file_name))
    @cohort_name = "A"
    @cohort_data = data.select { |row| row["cohort"] == @cohort_name }
                       .collect { |row| row["result"] }
    @cohort = Cohort.new(@cohort_name, @cohort_data)
  end

  describe '#initialize' do
    it 'sets Cohort instance with its name, 24 data points, and 10 convs' do
      expect(@cohort).to be_a(Cohort)
      expect(@cohort.name).to eq(@cohort_name)
      expect(@cohort.sample_size).to eq(24)
      expect(@cohort.conversions).to eq(10)
    end
  end

  describe '#calc_conversion_rate' do
    before do
      @cohort.calc_conversion_rate
    end

    it 'sets the conversion rate to be 0.416' do
      expect(@cohort.conversion_rate).to be_within(0.01).of(0.416)
    end
  end

  describe '#calc_standard_error' do
    before do
      @cohort.calc_conversion_rate
      @cohort.calc_standard_error
    end

    it 'sets the conversion rate to be 0.1006' do
      expect(@cohort.stnd_error).to be_within(0.01).of(0.1006)
    end
  end

  describe '#calc_confidence_intervals' do
    before do
      @cohort.calc_conversion_rate
      @cohort.calc_standard_error
      @cohort.calc_confidence_intervals
    end

    it 'sets the lower confidence interval to 0.218824' do
      expect(@cohort.lower_ci).to be_within(0.01).of(0.218824)
    end

    it 'sets the upper confidence interval to 0.613176' do
      expect(@cohort.upper_ci).to be_within(0.01).of(0.613176)
    end
  end

  describe '#conversion_statistics' do
    before do
      @stats = @cohort.conversion_statistics
    end

    it 'creates a hash of conversions and non-conversions' do
      expect(@stats).to be_a(Hash)
      expect(@stats[:conversions]).to eq(10)
      expect(@stats[:non_conversions]).to eq(14)
    end
  end
end
