require_relative "spec_helper"
require_relative "../lib/eve_central/quicklook_item"

describe EveCentral::QuicklookItem do
  include_context "item_ids"

  let(:item) do
    double("Tritanium",
           id: tritanium_id,
           name: tritanium_name,
           valid?: true)
  end

  let(:empty_ql) { EveCentral::QuicklookItem }

  let(:orders) do
    [double("Order 1", valid?: true),
     double("Order 2", valid?: true)]
  end

  it "can be initialized with no parameters" do
    expect(empty_ql).not_to be_nil
  end

  context "with valid item and orders" do
    subject(:ql) do
      EveCentral::QuicklookItem.new(item: item,
                                    buy_orders: orders,
                                    sell_orders: orders)
    end

    it { is_expected.to be_valid }
  end

  context "with a bad item" do
    let(:bad_item) { double("Bad Item", valid?: false) }

    subject(:ql) do
      EveCentral::QuicklookItem.new(item: bad_item,
                                    buy_orders: orders,
                                    sell_orders: orders)
    end

    it { is_expected.not_to be_valid }
  end

  context "with at least one invalid order" do
    let(:bad_orders) do
      [double("Order 1", valid?: true),
       double("Order 2", valid?: false)]
    end

    subject(:bad_ql) do
      EveCentral::QuicklookItem.new(item: item,
                                    sell_orders: bad_orders,
                                    buy_orders: orders)
    end

    it { is_expected.not_to be_valid }
  end
end
