require 'spec_helper'
require 'api_parser'

describe CongressApiParser do
  WebMock.disable!
  subject(:api) { CongressApiParser.new }
  let(:bills) { api.all_bills }
  
  describe "#all_bills" do
    it "returns all bills" do
      expect(bills).not_to be_empty
    end

    it "throws an exception unless HTTP status code is 200" do
      WebMock.enable!
      stub_request(:get, /congress.api.sunlightfoundation.com/).
         to_return(status: 401)
      expect{ api.all_bills }. to raise_error
    end
  end
end