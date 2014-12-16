require 'rails_helper'

RSpec.describe Order, type: :model do
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

  describe "#order_type" do
    it "must be 'buy' or 'sell'" do
      order.order_type = "sell"
      expect(order).to be_valid
      order.order_type = "buy"
      expect(order).to be_valid
      order.order_type = "free"
      expect(order).not_to be_valid
    end
  end

  describe ".last_queried_on" do
    subject(:last_queried) { Order.last_queried_on(item) }

    let(:item) do
      FactoryGirl.create(:item, in_game_id: 34, name: "Tritanium")
    end

    let(:other_item) do
      FactoryGirl.create(:item, in_game_id: 35, name: "Pyerite")
    end

    context "when no orders exist" do
      it { is_expected.to be_nil }
    end

    context "when no orders exist for the given item" do
      before(:each) do
        FactoryGirl.create(:order, item: other_item)
      end

      it { is_expected.to be_nil }
    end

    context "when orders exist for the given item" do
      before(:each) do
        FactoryGirl.create(:order,
                           item: item,
                           date_pulled: Date.new(2014, 10, 01))
        FactoryGirl.create(:order,
                           item: item,
                           date_pulled: Date.new(2014, 11, 03))
        FactoryGirl.create(:order,
                           item: item,
                           date_pulled: Date.new(2014, 10, 31))
        FactoryGirl.create(:order,
                           item: other_item,
                           date_pulled: Date.new(2014, 11, 05))
      end

      it "is the maximum date_pulled of the orders for that item" do
        expect(last_queried).to eq(Date.new(2014, 11, 03))
      end
    end
  end

  describe ".update_from_api" do
    let(:item) do
      FactoryGirl.create(:item,
                         in_game_id: 34,
                         name: "Tritanium")
    end

    subject(:update_from_api) { Order.update_from_api(item) }
    let(:force_update) { Order.update_from_api(item, true) }

    context "when no orders exist" do
      it "updates the orders" do
        expect(ApiOrder).to receive(:update).once
        update_from_api
      end
    end

    context "when matching orders exist and have not been updated for at least 24 hrs" do
      before(:each) do
        FactoryGirl.create_list(:order,
                                10,
                                item: item,
                                date_pulled: Date.today - 2)
      end

      it "updates the orders" do
        expect(ApiOrder).to receive(:update).once
        update_from_api
      end
    end

    context "when matching recent orders exist" do
      before(:each) do
        FactoryGirl.create_list(:order,
                                10,
                                item: item,
                                date_pulled: Date.today)
      end

      it "does not update the orders" do
        expect(ApiOrder).not_to receive(:update)
        update_from_api
      end

      context "and forced" do
        it "updates the orders" do
          expect(ApiOrder).to receive(:update)
          force_update
        end
      end
    end
  end
end
