require 'rspec'
require_relative '../lib/data_manager'
require_relative '../lib/json_reader'
require_relative 'constants'

describe 'Data Manager' do
  describe 'Initialization' do
    before :each do
      @reader = JsonReader.new
      @data_manager = DataManager.new
    end

    context 'when initialized data manager' do
      it 'should not be nil' do
        expect(@data_manager).not_to be_nil
      end
    end

    describe ".load" do
      it "should load a 'JSON reader' without blowing up" do
        expect(@data_manager.load(@reader)).not_to be_nil
      end
    end
  end

  describe '.total_sample_size' do
    before :each do
      @reader = JsonReader.new
      @reader.load_data(JSON_FILE_PATH)
      @data_manager = DataManager.new
      @data_manager.load(@reader)
    end

    context 'before loading a reader' do
      it 'should have an empty total sample size' do
        expect(DataManager.new.total_sample_size).to eq(0)
      end
    end

    context 'after loading a reader' do
      it 'should have the total sample size' do
        expect(@data_manager.total_sample_size).to eq(2892)
      end
    end

    context 'sample size per cohort' do
      it 'should have a total sample size of 1543 for cohort B' do
        expect(@data_manager.total_sample_size("B")).to eq(1543)
      end
    end

    context 'sample size per cohort' do
      it 'should have a total sample size of 0 for cohort C' do
        expect(@data_manager.total_sample_size("C")).to eq(0)
      end
    end
  end

  describe '.total_conversions_size' do
    before :each do
      @reader = JsonReader.new
      @reader.load_data(JSON_FILE_PATH)
      @data_manager = DataManager.new
      @data_manager.load(@reader)
    end

    context 'before loading a reader' do
      it 'should have an empty total conversion size' do
        expect(DataManager.new.total_conversion_size).to eq(0)
      end
    end

    context 'after loading a reader' do
      it 'should have the total conversion size' do
        expect(@data_manager.total_conversion_size).to eq(126)
      end
    end

    context 'conversion count per cohort' do
      it 'should have a total conversion rate for cohort B' do
        expect(@data_manager.total_conversion_size("A")).to eq(47)
      end
    end
  end

  describe '.conversion_rate' do
    before :each do
      @reader = JsonReader.new
      @reader.load_data(JSON_FILE_PATH)
      @data_manager = DataManager.new
      @data_manager.load(@reader)
    end

    context 'before loading a reader' do
      it 'should have zero conversion rate' do
        expect(DataManager.new.conversion_rate).to eq(0)
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
      @reader = JsonReader.new
      @reader.load_data(JSON_FILE_PATH)
      @data_manager = DataManager.new
      @data_manager.load(@reader)
    end

    it 'should have 0.42 rate' do
      expect(@data_manager.calculate_chi_square).to eq(0.042)
    end
  end
end
