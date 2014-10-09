require_relative "spec_helper"
require_relative "../lib/eve_central/order"

describe EveCentral::Order do
  let(:order) { EveCentral::Order.new(1000) }

  it "can be initialized with an ID" do
    expect(order.id).to eq(1000)
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
