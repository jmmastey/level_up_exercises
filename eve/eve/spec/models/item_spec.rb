require 'rails_helper'

RSpec.describe Item, type: :model do
  subject(:item) { FactoryGirl.create(:item) }

  it "requires an in-game ID" do
    item.in_game_id = nil
    expect(item).not_to be_valid
  end

  it "requires a name" do
    item.name = nil
    expect(item).not_to be_valid
  end

  describe "#in_game_id" do
    it "must be a number" do
      item.in_game_id = "Joe"
      expect(item).not_to be_valid
    end

    it "must be non-negative" do
      item.in_game_id = -1
      expect(item).not_to be_valid
    end
  end
end
