require "rails_helper"
require "json"

describe Locu::Client do
  let(:api_key) { "Mock Key" }
  let(:client) { described_class.new(api_key) }

  it "is initialized with an API key" do
    expect { client }.not_to raise_error
  end

  describe "#search_venues" do
    let(:url) { "#{described_class::HOST}/v2/venue/search" }
    let(:params) { { location: { zip: "60604" } } }
    let(:response) { { success: true }.to_json }
    subject(:search) { client.search_venues(params) }

    before(:each) do
      stub_request(:post, url).to_return(
        body: response,
        headers: { "Content-Type" => "application/json" },
      )
    end

    it "calls the Locu API with the API key" do
      search

      expect(WebMock).to have_requested(:post, url)
        .with(body: hash_including("api_key" => api_key))
    end

    it "includes any venue parameters included" do
      expected_body = {
        "venue_queries" => [{ "location" => { "zip" => "60604" } }],
      }

      search

      expect(WebMock).to have_requested(:post, url)
        .with(body: hash_including(expected_body))
    end

    it "is a hash of the result JSON" do
      expect(search).to include("success" => true)
    end

    context "when the result is not valid JSON" do
      let(:response) { "invalid JSON" }

      it "raises an error" do
        expect { search }.to raise_error
      end
    end
  end
end
