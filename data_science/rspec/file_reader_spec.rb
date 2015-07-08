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
