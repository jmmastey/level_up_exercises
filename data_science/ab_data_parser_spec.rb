require 'spec_helper'

require_relative 'ab_data_parser'

describe ABDataParser do
  subject(:parser) { ABDataParser.new }

  context 'When passing invalid arguments' do
    it 'with 0 arugment' do
      expect { parser.parse_data }.to raise_error(ArgumentError)
    end

    it 'with invalid json obj' do
      args = {  file_name: 'test.json', variant_ke: 'test',
                result: 'test' }
      expect { parser.parse_data(args) }.to raise_error(ArgumentError)
    end

    it 'with non-json file' do
      args = {  file_name: 'test.csv',
                variant_key: 'Test', result_key: 'result' }
      expect { parser.parse_data(args) }.to raise_error(InvalidFileTypeError)
    end

    it 'with unkonwn file' do
      args = {  file_name: 'test.json',
                variant_key: 'Test', result_key: 'result' }
      expect { parser.parse_data(args) }.to raise_error(FileNotFoundError)
    end
  end

  context 'When passing valid argument' do
    let(:returned_result) do
      option = { file_name: 'source_data.json',
                 variant_key: 'cohort', result_key: 'result' }
      parser.parse_data(option)
    end
    subject { returned_result }

    it 'should not be empty' do
      expect(returned_result).not_to be_empty
    end

    context 'result should contain two variants A and B' do
      it 'should have A' do
        expect(returned_result).to have_key(:A)
      end

      it 'should have B' do
        expect(returned_result).to have_key(:B)
      end
    end

    let(:variant_a) { returned_result[:A] }
    subject { variant_a }

    context 'Variant A should has two keys' do
      it 'should have total_samples' do
        expect(variant_a).to have_key(:total_samples)
      end
      it 'should have conversions' do
        expect(variant_a).to have_key(:conversions)
      end
    end

    it 'Total samples of variant A should be 1349' do
      expect(variant_a[:total_samples].to_i).to eq(1349)
    end

    it 'conversions count of variant a should be 47' do
      expect(variant_a[:conversions].to_i).to eq(47)
    end
  end
end
