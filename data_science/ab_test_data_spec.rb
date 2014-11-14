require 'spec_helper'
require_relative 'ab_test_data'

describe ABTestData do
  context 'When instentiate a ABTestData' do
    it 'with empty hash' do
      expect { ABTestData.new }.to raise_error(ArgumentError)
    end
    it 'with wrong keys' do
      error_message = 'The json does not contains require keys'
      expect do
        ABTestData.new(total_sample: 100, conversions: 11)
      end.to raise_error(error_message)

      expect do
        ABTestData.new(total_samples: 100, conversion: 11)
      end.to raise_error(error_message)
    end
    it 'with negative numbers' do
      error_message = 'Both total_samples and conversions can not be negative'
      expect do
        ABTestData.new(total_samples: -100, conversions: 11)
      end.to raise_error(error_message)

      expect do
        ABTestData.new(total_samples: 100, conversions: -11)
      end.to raise_error(error_message)
    end
  end

  context 'Calling methods' do
    subject(:ab_data) do
      ABTestData.new(total_samples: 100, conversions: 20)
    end

    it 'conversion_rate equal to 0.2' do
      expect(ab_data.conversion_rate).to be_within(0.01).of(0.2)
    end

    it 'standard_error should be close 0.04' do
      expect(ab_data.standard_error).to be_within(0.001).of(0.04)
    end

    it 'distribution_range shoulbe be' do
      expect(ab_data.distribution_range).to match_array([0.1216, 0.2784])
    end
  end

  context 'When conversion is 0' do
    subject(:ab_data) do
      ABTestData.new(total_samples: 100, conversions: 0)
    end

    it { expect(ab_data.conversion_rate).to eq(0) }
    it { expect(ab_data.standard_error).to eq(0) }
    it { expect(ab_data.distribution_range).to match_array([0, 0]) }
  end
end
