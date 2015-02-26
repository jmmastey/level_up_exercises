require 'spec_helper'
# require 'api_parser'
require 'httparty'

describe "Sunglight Foundation API Bill Format" do


  describe "bill response format" do
          include HTTParty

      base_uri 'congress.api.sunlightfoundation.com'
      default_params apikey: '23b3ee3083ea405dbb84c2b3476efcd6'
      bill_params = { query: { per_page: 50, page: 1, order: "introduced_on" } }
    it "blah" do
       stub_request(:get, "http://congress.api.sunlightfoundation.com/bills/?apikey=23b3ee3083ea405dbb84c2b3476efcd6&history.enacted=true&order=introduced_on&page=1&per_page=50").
         to_return(:status => 401, :body => "", :headers => {})
      bills = self.class.get("/bills/?history.enacted=true", bill_params)
    end
  end
end