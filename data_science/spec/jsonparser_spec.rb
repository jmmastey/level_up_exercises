require 'spec_helper'
require_relative '../jsonparser.rb'

describe JSONParser do

  describe '#read_data' do
    it "should return a hash" do
      data = JSONParser.read_data("sample.json")
      expect(data.is_a?(Array)).to be_truthy
    end

    it "should return data" do
      data = JSONParser.read_data("sample.json")
      expect(data.empty?).to be_falsey
    end
  end

end
