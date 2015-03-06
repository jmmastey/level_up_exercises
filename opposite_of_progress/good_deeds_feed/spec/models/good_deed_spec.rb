require 'rails_helper'
require 'json'

RSpec.describe GoodDeed, type: :model do
  describe "#by_party" do
    it "filters good deeds by party" do
      D_deed = FactoryGirl.create(:good_deed, legislator:
                FactoryGirl.create(:legislator, party: "D"))
      R_deed = FactoryGirl.create(:good_deed, legislator:
                FactoryGirl.create(:legislator, party: "R"))
      I_deed = FactoryGirl.create(:good_deed, legislator:
                FactoryGirl.create(:legislator, party: "I"))
      expect(GoodDeed.by_party("D").first).to eq(D_deed)
      expect(GoodDeed.by_party("R").first).to eq(R_deed)
      expect(GoodDeed.by_party("I").first).to eq(I_deed)
    end
  end

  describe "#to_json" do
    it "returns good deed data in JSON format" do
      FactoryGirl.create_list(:good_deed, 5)
      json_deeds = GoodDeed.to_json
      expect { JSON.parse(json_deeds) }.not_to raise_error
      expect(JSON.parse(json_deeds).length).to eq(5)
    end
  end
end
