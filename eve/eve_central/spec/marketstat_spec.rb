require "vcr"
require_relative "spec_helper"
require_relative "../lib/eve_central/marketstat.rb"

describe EveCentral::Marketstat do
  include_context "item_ids"

  let(:api_url) { "http://api.eve-central.com/api/marketstat" }
  let(:custom_url) { "http://api.eve-central.com/api/alt-marketstat" }
  let(:marketstat) { EveCentral::Marketstat.new }
  let(:custom_marketstat) { EveCentral::Marketstat.new(custom_url) }

  it "can be initialized with no parameters" do
    expect(marketstat).not_to be nil
  end

  it "defaults to using 'http://api.eve-central.com/api/marketstat' as the API URL" do
    expect(marketstat.url).to eq(api_url)
  end

  it "can be initialized with a custom API URL" do
    expect(custom_marketstat.url).to eq(custom_url)
  end

  describe "#request" do
    context "when given a single item ID" do
      # TODO: Rename request
      subject(:basic_item_request) do
        VCR.use_cassette("marketstat_basic_response") do
          marketstat.request(tritanium_id)
        end
      end

      it { is_expected.to have(1).items }

      it "has one MarketstatItem with stats for the requested item ID" do
        expect(basic_item_request[0]).to be_a(EveCentral::MarketstatItem)
        expect(basic_item_request[0].item_id).to eq(tritanium_id)
      end
    end

    context "when given a collection of item IDs" do
      subject(:multi_item_request) do
        VCR.use_cassette("marketstat_multi_response") do
          marketstat.request([tritanium_id, pyerite_id])
        end
      end

      it "returns a collection of stats for each item requested" do
        expect(multi_item_request).to have(2).items
        multi_item_request.each do |item|
          expect(item.item_id).to eq(tritanium_id).or eq(pyerite_id)
        end
      end
    end

    context "when given no arguments" do
      subject(:empty_request) { marketstat.request }

      it "is expected to raise an error" do
        expect { empty_request }.to raise_error
      end
    end
  end
end
