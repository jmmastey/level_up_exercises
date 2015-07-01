require_relative 'spec_helper'
require 'pry'
RSpec.describe DataLoader do
  let(:data) { DataLoader.new('../testabdata_sample.json') }
  SAMPLE_SIZE = 70
  describe 'total_sample_size' do
    it 'returns 70 for our test data' do
      expect(data.total_sample_size).to eq(SAMPLE_SIZE)
    end
  end

  describe 'not passing a file name to DataLoader' do
    it 'raises a run time error You did not enter a file name' do
      expect { DataLoader.new('') }.to raise_error(RuntimeError, 'You did not enter a file name')
    end
  end
end
