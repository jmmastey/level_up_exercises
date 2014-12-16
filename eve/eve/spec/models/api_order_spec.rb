require "rails_helper"

describe ApiOrder, type: :model do
  let(:item) { FactoryGirl.create(:item, in_game_id: 34) }
  let(:min_date) { Date.today - 7 }

  describe ".update", :vcr do
    subject(:updated) { ApiOrder.update(item, min_date) }

    it { is_expected.to be_an(Enumerable) }

    it "is expected to contain orders" do
      expect(updated).to all(be_an(Order))
    end

    it "only includes orders for the given item" do
      updated.each do |order|
        expect(order.item).to eq(item)
      end
    end
  end
end
