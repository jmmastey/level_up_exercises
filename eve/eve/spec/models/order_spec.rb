require 'rails_helper'

RSpec.describe Order, :type => :model do
  subject(:order) { FactoryGirl.build(:order) }

  it "requires an item" do
    order.item = nil
    expect(order).not_to be_valid
  end

  it "requires a region" do
    order.region = nil
    expect(order).not_to be_valid
  end

  it "requires a station" do
    order.station = nil
    expect(order).not_to be_valid
  end

  it "requires an in-game ID" do
    order.in_game_id = nil
    expect(order).not_to be_valid
  end

  it "requires a price" do
    order.price = nil
    expect(order).not_to be_valid
  end

  it "requires a security level" do
    order.security = nil
    expect(order).not_to be_valid
  end

  describe "#price" do
    it "must be greater than or equal to 0" do
      order.price = 0
      expect(order).to be_valid

      order.price = -0.1
      expect(order).not_to be_valid
    end
  end

  describe "#security" do
    it "must be greater than or equal to -1.0" do
      order.security = -1
      expect(order).to be_valid

      order.security = -1.1
      expect(order).not_to be_valid
    end

    it "must be less than or equal to 1.0" do
      order.security = 1
      expect(order).to be_valid

      order.security = 1.1
      expect(order).not_to be_valid
    end
  end

  describe "#type" do
    it "must be 'buy' or 'sell'" do
      order.type = "sell"
      expect(order).to be_valid
      order.type = "buy"
      expect(order).to be_valid
      order.type = "free"
      expect(order).not_to be_valid
    end
  end

  describe "::last_pulled_on" do
    subject(last_pulled) { Order.last_pulled_on(item) }

    context "when no orders exist" do
      it { is_expected.to be_nil }
    end

    context "when no orders exist with the given item"
  end
end
