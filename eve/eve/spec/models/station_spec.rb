require 'rails_helper'

RSpec.describe Station, type: :model do
  subject(:station) { FactoryGirl.build(:station) }

  it "requires an in-game ID" do
    station.in_game_id = nil
    expect(station).not_to be_valid
  end

  it "requires a name" do
    station.name = nil
    expect(station).not_to be_valid
  end

  describe "#in_game_id" do
    it "must be a number" do
      station.in_game_id = "Joe"
      expect(station).not_to be_valid
    end

    it "must be non-negative" do
      station.in_game_id = -1
      expect(station).not_to be_valid
    end
  end
end
