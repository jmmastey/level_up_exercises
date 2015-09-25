require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "#zone?" do
    context "when the category's blizzard_type is zone" do
      let(:category) { FactoryGirl.create(:category, blizzard_type: "zone") }
      it "should be true" do
        expect(category.zone?).to be true
      end
    end
    context "when the category's blizzard_type is seasonal" do
      let(:category) { FactoryGirl.create(:category, blizzard_type: "other") }
      it "should be false" do
        expect(category.zone?).to be false
      end
    end
  end

  describe "#character_activities" do
    skip
  end

  describe ".all_zones" do
    context "when 2 of the 3 categories are zones" do
      let(:zone1) do
        FactoryGirl.create(:category, name: "zone1", blizzard_type: "zone")
      end
      let(:other1) do
        FactoryGirl.create(:category, name: "other1", blizzard_type: "other")
      end
      let(:zone2) do
        FactoryGirl.create(:category, name: "zone2", blizzard_type: "zone")
      end

      it "should return the 2 zones" do
        expect(Category.all_zones).to match_array([zone1, zone2])
      end
    end
  end

  describe ".name_to_id" do
    let!(:zone) do
      FactoryGirl.create(:category, name: "zone1", blizzard_type: "zone",
                         id: "7")
    end

    it "returns the id of the named category" do
      expect(Category.name_to_id("zone1")).to eq(7)
    end
  end
end
