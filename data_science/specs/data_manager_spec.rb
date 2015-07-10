require 'rspec'
require_relative '../lib/data_manager'

def test_hash
  result = []
  1464.times { result << { 'cohort' => "B", "result" => 0 } }
  1302.times { result << { 'cohort' => "A", "result" => 0 } }
  47.times { result << { 'cohort' => "A", "result" => 1 } }
  79.times { result << { 'cohort' => "B", "result" => 1 } }
  result
end

describe 'DataManager' do
  before :each do
    @data_manager = DataManager.new
  end
  let(:data_manager) { DataManager.new }
  describe '#new' do
    context 'when initialized data manager' do
      it 'should not be nil' do
        expect(data_manager).not_to be_nil
      end
    end
  end

  describe '.load' do
    it 'should load a reader without blowing up' do
      double_reader = double
      allow(double_reader).to receive(:data_hash).and_return(test_hash)
      expect(data_manager.load(double_reader)).not_to be_nil
    end
  end

  describe '.sample_size' do
    before :each do
      double_reader = double
      allow(double_reader).to receive(:data_hash).and_return(test_hash)
      @data_manager.load(double_reader)
    end

    context 'before loading a reader' do
      it 'should raise an exception' do
        expect { DataManager.new.sample_size }.to raise_error ArgumentError
      end
    end

    context 'after loading a reader' do
      it 'should have the total sample size' do
        expect(@data_manager.sample_size).to eq(2892)
      end
    end

    context 'sample size per cohort' do
      it 'should have a total sample size of 1543 for cohort B' do
        expect(@data_manager.sample_size("B")).to eq(1543)
      end
    end

    context 'sample size per cohort' do
      it 'should have a total sample size of 0 for cohort C' do
        expect(@data_manager.sample_size("C")).to eq(0)
      end
    end
  end

  describe '.conversions_size' do
    before :each do
      double_reader = double
      allow(double_reader).to receive(:data_hash).and_return(test_hash)
      @data_manager.load(double_reader)
    end

    context 'before loading a reader' do
      it 'should raise an error' do
        expect { DataManager.new.conversion_rate }.to raise_error ArgumentError
      end
    end

    context 'after loading a reader' do
      it 'should have the total conversion size' do
        expect(@data_manager.conversion_size).to eq(126)
      end
    end

    context 'conversion count per cohort' do
      it 'should have a total conversion rate for cohort B' do
        expect(@data_manager.conversion_size("A")).to eq(47)
      end
    end
  end

  describe '.conversion_rate' do
    before :each do
      double_reader = double
      allow(double_reader).to receive(:data_hash).and_return(test_hash)
      @data_manager.load(double_reader)
    end

    context 'before loading a reader' do
      it 'should raise an error' do
        expect { DataManager.new.conversion_rate }.to raise_error ArgumentError
      end
    end

    context 'conversion rate' do
      it 'A should have a conversion rate of 3.48%' do
        expect(@data_manager.conversion_rate("A")).to eq(3.48)
      end
    end

    context 'conversion rate' do
      it 'B should have a conversion rate of 5.12%' do
        expect(@data_manager.conversion_rate("B")).to eq(5.12)
      end
    end
  end

  describe '.calculate_chi_square' do
    before :each do
      double_reader = double
      allow(double_reader).to receive(:data_hash).and_return(test_hash)
      @data_manager.load(double_reader)
    end

    context 'before loading a reader' do
      it 'should raise an error' do
        expect { DataManager.new.calc_chi_square }.to raise_error ArgumentError
      end
    end

    it 'should have 0.32 rate' do
      expect(@data_manager.calc_chi_square).to eq(0.032)
    end
  end
end
