require_relative "spec_helper"
require_relative "../lib/eve_central/order"

describe EveCentral::Order do
  let(:blank_order) { EveCentral::Order.new }
  let(:order) { EveCentral::Order.new(id: 1000) }

  it "can be initialized without parameters" do
    expect(blank_order).not_to be_nil
  end

  it "can be initialized with a hash of stats" do
    expect(order.id).to eq(1000)
  end

  it "should never be persisted" do
    expect(order).not_to be_persisted
  end

  it "should require an ID" do
    order.id = nil
    expect(order).not_to be_valid
  end

  it "should require the ID be an integer" do
    order.id = 3.5
    expect(order).not_to be_valid
  end

  it "should require the ID be non-negative" do
    order.id = -1
    expect(order).not_to be_valid
  end

  it "should be valid if any fields except the ID are nil" do
    expect(order).to be_valid
  end

  it "should require the region ID to be an integer" do
    order.region_id = 0.50
    expect(order).not_to be_valid
  end

  it "should require the region ID to be non-negative" do
    order.region_id = -1
    expect(order).not_to be_valid
  end

  it "should require the security valiue to be between -1.0 and 1.0" do
    order.security = 0
    expect(order).to be_valid

    order.security = -1.0
    expect(order).to be_valid

    order.security = 1.0
    expect(order).to be_valid

    order.security = -1.1
    expect(order).not_to be_valid

    order.security = 1.1
    expect(order).not_to be_valid
  end

  it "should require the price to be non-negative" do
    order.price = 0
    expect(order).to be_valid

    order.price = 50
    expect(order).to be_valid

    order.price = -1
    expect(order).not_to be_valid
  end

  it "should require the volume remaining to be an integer" do
    order.volume_remaining = 0.50
    expect(order).not_to be_valid
  end

  it "should require the volume remaining to be non-negative" do
    order.volume_remaining = 0
    expect(order).to be_valid

    order.volume_remaining = 1
    expect(order).to be_valid

    order.volume_remaining = -1
    expect(order).not_to be_valid
  end

  it "should require the minimum volume to be an integer" do
    order.min_volume = 0.50
    expect(order).not_to be_valid
  end

  it "should require the minimum volume to be non-negative" do
    order.min_volume = 0
    expect(order).to be_valid

    order.min_volume = 1
    expect(order).to be_valid

    order.min_volume = -1
    expect(order).not_to be_valid
  end

  describe "#expired?" do
    context "when the expiry date has passed" do
      subject(:expired_order) do
        order.expires = Time.now.utc - 1000
        order
      end

      it { is_expected.to be_expired }
    end

    context "when the expiry date is in the future" do
      subject(:active_order) do
        order.expires = Time.now.utc + 1000
        order
      end

      it { is_expected.not_to be_expired }
    end
  end
end
