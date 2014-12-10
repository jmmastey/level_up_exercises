require 'rails_helper'

RSpec.describe Region, type: :model do
  subject(:region) { FactoryGirl.create(:region) }

  it "requires an in-game ID" do
    region.in_game_id = nil
    expect(region).not_to be_valid
  end

  it "requires a name" do
    region.name = nil
    expect(region).not_to be_valid
  end

  describe "#in_game_id" do
    it "must be a number" do
      region.in_game_id = "Joe"
      expect(region).not_to be_valid
    end

    it "must be non-negative" do
      region.in_game_id = -1
      expect(region).not_to be_valid
    end
  end
end
