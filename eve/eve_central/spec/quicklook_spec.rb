require "vcr"
require_relative "spec_helper"
require_relative "../lib/eve_central/quicklook"

describe EveCentral::Quicklook do
  include_context "item_ids"

  let(:api_url) { "http://api.eve-central.com/api/quicklook" }
  let(:custom_url) { "http://api.eve-central.com/api/alt-quicklook" }
  let(:quicklook) { EveCentral::Quicklook.new }
  let(:custom_quicklook) { EveCentral::Quicklook.new(custom_url) }

  it "can be initialized with no parameters" do
    expect(quicklook).not_to be nil
  end

  it "defaults to using 'api.eve-central.com/api/quicklook' as the API URL" do
    expect(quicklook.url).to eq(api_url)
  end

  it "can be initialized with a custom API URL" do
    expect(custom_quicklook.url).to eq(custom_url)
  end

  describe "#request" do
    context "when given an item ID" do
      subject(:response) do
        VCR.use_cassette("quicklook_response") do
          quicklook.request(tritanium_id)
        end
      end

      it "returns a response for that item" do
        expect(response.item.id).to eq(tritanium_id)
      end

      it "contains a collection of valid buy orders" do
        expect(response.buy_orders).to be_an(Enumerable)
        response.buy_orders.all? do |order|
          expect(order).to be_valid
        end
      end

      it "contains a collection of valid sell orders" do
        expect(response.sell_orders).to be_an(Enumerable)
        response.sell_orders.all? do |order|
          expect(order).to be_valid
        end
      end
    end

    context "when not given any parameters" do
      subject(:bad_request) { quicklook.request }

      it "raises an error" do
        expect { bad_request }.to raise_error
      end
    end
  end
end
