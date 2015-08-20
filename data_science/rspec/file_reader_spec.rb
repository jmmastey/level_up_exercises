require_relative '../file_reader'

describe FileReader do
  context 'positive' do
    let(:file_path) { "test.json" }
    subject(:test_file_reader) { FileReader.new(file_path) }
    it "should exist as an object" do
      expect(test_file_reader).to_not eq nil
    end

    it "should load data from the file" do
      expect(test_file_reader.data).to_not be_empty
    end

    it "should return a valid array after processing test.json" do
      expect(test_file_reader.data.is_a?(Array)).to eq(true)
    end

    it "should return hashes within the resulting array" do
      expect(test_file_reader.data.all? { |a| a.is_a?(Hash) }).to be true
    end
  end

  context 'negative' do
    let(:file_path_nil) { nil }
    let(:file_path_invalid) { 'file.file' }

    it "should throw an error on a nil file path" do
      expect { FileReader.new(file_path_nil) }.to raise_error(IOError)
    end

    it "should throw an error on a nil file path" do
      expect { FileReader.new(file_path_invalid) }.to raise_error(IOError)
    end
  end
end
