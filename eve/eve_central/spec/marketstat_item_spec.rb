require_relative "spec_helper"
require_relative "../lib/eve_central/marketstat_item"

describe EveCentral::MarketstatItem do
  include_context "item_ids"

  let(:empty_item) { EveCentral::MarketstatItem.new(tritanium_id) }
  let(:bad_item) { EveCentral::MarketstatItem.new }
  let(:stats) { :mock_stat_group }

  let(:filled_item) do
    EveCentral::MarketstatItem.new(tritanium_id,
                                   buy_stats: stats,
                                   sell_stats: stats,
                                   all_stats: stats)
  end

  it "can be initialized with an item ID" do
    expect(empty_item.item_id).to eq(tritanium_id)
  end

  it "can be initialized with stats specified" do
    expect(filled_item.item_id).to eq(tritanium_id)
    expect(filled_item.buy_stats).to be stats
    expect(filled_item.sell_stats).to be stats
    expect(filled_item.all_stats).to be stats
  end

  it "raises an error if no item ID is specified" do
    expect { bad_item }.to raise_error
  end
end
