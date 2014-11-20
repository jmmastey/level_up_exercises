require 'spec_helper'
require_relative 'ab_test_data'

describe ABTestData do
  context 'when instantiate a ABTestData' do
    it 'with empty hash' do
      expect { ABTestData.new }.to raise_error(ArgumentError)
    end
    it 'with wrong keys' do
      data = { total_sample: 1, conversions: 1 }
      expect { ABTestData.new(data) }.to raise_error(RuntimeError)

      data = { total_samples: 1, conversion: 1 }
      expect { ABTestData.new(data) }.to raise_error(RuntimeError)
    end
  end

  context 'when object is instantiated' do
    subject(:ab_data) do
      ABTestData.new(total_samples: 100, conversions: 20)
    end

    it 'has conversion rate of 0.2' do
      expect(ab_data.conversion_rate).to be_within(0.01).of(0.2)
    end

    it 'has standard error close to 0.04' do
      expect(ab_data.standard_error).to be_within(0.001).of(0.04)
    end

    it 'has distribution range between 0.1216 to 0.2784' do
      expect(ab_data.distribution_range).to match_array([0.1216, 0.2784])
    end
  end

  context 'when object is instantiated and conversion is 0' do
    data = { total_samples: 100, conversions: 0 }
    subject(:ab_data) { ABTestData.new(data) }

    it 'has conversion rate of 0' do
      expect(ab_data.conversion_rate).to eq(0)
    end

    it 'has standard error of 0' do
      expect(ab_data.standard_error).to eq(0)
    end

    it 'has distribution range between 0 to 0' do
      expect(ab_data.distribution_range).to match_array([0, 0])
    end
  end
end
