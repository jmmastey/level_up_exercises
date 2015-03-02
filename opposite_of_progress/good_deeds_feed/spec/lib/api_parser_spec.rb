require 'spec_helper'
require 'api_parser'
require 'webmock/rspec'

RSpec.describe CongressApiParser do
  subject(:api) { CongressApiParser.new }
  let(:raw_response_file) { File.new("./spec/lib/raw_api_data.txt") }
  let(:bill_keys) { [:congress_number, :congress_url, :official_title,
                      :introduced_on, :bioguide_id, :short_title] 
                    }

  describe "#all_bills" do
    it "returns all bills with correct hash keys" do
      stub_request(:get, /congress.api.sunlightfoundation.com/).
        to_return(raw_response_file)
      api.all_bills.each do |bill|
        expect(bill).to include(*bill_keys)
      end
    end

    it "throws an exception if HTTP status code is not 200" do
      stub_request(:get, /congress.api.sunlightfoundation.com/).
        to_return(status: 401)
      expect { api.all_bills }.to raise_error
    end

    it "throws an exception if bill formatting changes" do
      response_with_bad_data = File.new("./spec/lib/data_with_bad_format.txt")
      stub_request(:get, /congress.api.sunlightfoundation.com/).
        to_return(response_with_bad_data)
      expect { api.all_bills }.to raise_error
    end
  end
end
