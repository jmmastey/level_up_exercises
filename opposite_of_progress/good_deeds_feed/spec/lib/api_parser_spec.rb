require 'spec_helper'
require 'api_parser'
require 'webmock/rspec'


describe CongressApiParser do
  #WebMock.allow_net_connect!
  subject(:api) { CongressApiParser.new }
  #let(:bills) { api.all_bills }
  let(:raw_response_file) { File.new("./spec/lib/raw_api_data.txt") }
  
  describe "#all_bills" do
    it "returns all bills" do
      stub_request(:get, /congress.api.sunlightfoundation.com/).
        to_return(raw_response_file)
      expect(api.all_bills).not_to be_empty
    end

    it "throws an exception if HTTP status code is not 200" do
      stub_request(:get, /congress.api.sunlightfoundation.com/).
         to_return(status: 401)
      expect{ api.all_bills }.to raise_error
    end

    it "throws an exception if bill formatting changes" do
      response_with_bad_data = File.new("./spec/lib/data_with_bad_format.txt")
      stub_request(:get, /congress.api.sunlightfoundation.com/).
         to_return(response_with_bad_data)
      expect{ api.all_bills }.to raise_error
    end
  end
end