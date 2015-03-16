require_relative "spec_helper"

describe FileParser do
  FILE_NOEXIST = "foo.json"
  FILE_EMPTY = "data_empty.json"
  FILE_TOO_SMALL = "data_too_small.json"

  describe "#parse" do
    it "should raise an error if data file does not exist" do
      expect { FileParser.new(FILE_NOEXIST) }.to raise_error
    end
    it "should raise an error if data file is empty" do
      expect { FileParser.new(FILE_EMPTY) }.to raise_error
    end
    it "should raise an error if data file contains too few results" do
      expect { FileParser.new(FILE_TOO_SMALL) }.to raise_error
    end
  end
end
