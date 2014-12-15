require "rails_helper"

describe ApiOrder, type: :model do
  let(:item) { FactoryGirl.create(:item, in_game_id: 34) }

  describe ".update", :vcr do
    subject(:updated) { ApiOrder.update(item) }

    it { is_expected.to be_an(Enumerable) }
    it { is_expected.to all(be_an(Order)) }
  end
end
