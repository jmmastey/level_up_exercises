require 'spec_helper'

describe JsonParser do
  describe "#parse" do
    it "errors when invalid file is passed" do
      expect { described_class.parse("bogus file") }.to raise_error ArgumentError
    end

    it "parses json and stores results in to hash" do

    end
  end
end