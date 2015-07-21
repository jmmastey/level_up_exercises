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
  let(:double_reader) do
    double_reader = double
    allow(double_reader).to receive(:data_hash).and_return(test_hash)
    double_reader
  end
  let(:manager) { DataManager.new double_reader }

  describe '#new' do
    context 'when initialized data manager' do
      it 'should not be nil' do
        expect(manager).not_to be_nil
      end
    end

    context 'when initialized with reader it should not blow up' do
      it 'should not be nil' do
        expect(manager).not_to be_nil
      end
    end
  end

  describe '#sample_size' do
    context 'before loading a reader' do
      it 'should raise an exception' do
        expect { DataManager.new(nil).sample_size }.to raise_error ArgumentError
      end
    end

    context 'after loading a reader' do
      it 'should have the total sample size' do
        expect(manager.sample_size).to eq(2892)
      end
    end

    context 'sample size per cohort' do
      it 'should have a total sample size of 1543 for cohort B' do
        expect(manager.sample_size(:B)).to eq(1543)
      end
    end

    context 'sample size per cohort' do
      it 'should have a total sample size of 0 for cohort C' do
        expect(manager.sample_size(:C)).to eq(0)
      end
    end
  end

  describe '#conversions_size' do
    context 'before loading a reader' do
      it 'should raise an error' do
        expect do
          DataManager.new(nil).conversion_rate
        end.to raise_error(ArgumentError)
      end
    end

    context 'after loading a reader' do
      it 'should have the total conversion size' do
        expect(manager.conversion_size).to eq(126)
      end
    end

    context 'conversion count per cohort' do
      it 'should have a total conversion rate for cohort B' do
        expect(manager.conversion_size(:A)).to eq(47)
      end
    end
  end

  describe '#conversion_rate' do
    context 'before loading a reader' do
      it 'should raise an error' do
        expect do
          DataManager.new(nil).conversion_rate
        end.to raise_error(ArgumentError)
      end
    end

    context 'conversion rate' do
      it 'A should have a conversion rate of 3.48%' do
        expect(manager.conversion_rate(:A)).to eq(3.48)
      end
    end

    context 'conversion rate' do
      it 'B should have a conversion rate of 5.12%' do
        expect(manager.conversion_rate(:B)).to eq(5.12)
      end
    end
  end

  describe '#calculate_chi_square' do
    context 'before loading a reader' do
      it 'should raise an error' do
        expect do
          DataManager.new(nil).calc_chi_square
        end.to raise_error(ArgumentError)
      end
    end

    it 'should have 0.32 rate' do
      expect(manager.calc_chi_square).to eq(0.032)
    end
  end
end
