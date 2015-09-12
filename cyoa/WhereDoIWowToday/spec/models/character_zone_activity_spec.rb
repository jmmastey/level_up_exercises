require 'rails_helper'

RSpec.describe CharacterZoneActivity, type: :model do
  describe "#zone" do
    let(:cza) { FactoryGirl.create :character_zone_activity }
    
    it "should be equivalent to category" do
      expect(cza.zone).to eq(cza.category)
    end
  end

  describe "#quest_count" do
    context "when there are no quests" do
      before { FactoryGirl.create :character_zone_activity }

      it { "should be 0" }
    end

    context "when there are 3 quests" do
      before do
        3.times { FactoryGirl.create(:character_zone_activity, :quest) }
      end
      
      it { "should be 3" }
    end
  end

  describe "#achievement_count" do
    context "when there are no achievements" do
      before { FactoryGirl.create :character_zone_activity }

      it { "should be 0" }
    end

    xcontext "when there are 2 achievements" do
      before do
        2.times { FactoryGirl.create(:character_zone_activity, :achievement) }
      end
      
      it { "should be 2" }
    end
  end

  describe "#find_or_create" do
    context "when the cza exists" do
      let(:cza) { FactoryGirl.create(:character_zone_activity, :quest) }

      it "returns the cza" do
        character = cza.character
        category = cza.category
        quest = cza.quest

        response = CharacterZoneActivity.find_or_create(
          character: character, category: category, quest: quest)

        expect(response).to eq(cza)
      end
    end

    context "when the cza does not exist" do
      before { CharacterZoneActivity.destroy_all }
      
      it "returns a newly created cza" do
        character = FactoryGirl.create(:character)
        quest = FactoryGirl.create(:quest)
        category = FactoryGirl.create(:category)

        response = CharacterZoneActivity.find_or_create(
          character: character, category: category, quest: quest)

        expect(CharacterZoneActivity.count).to eq(1)
        expect(response.character).to eq(character)
        expect(response.category).to eq(category)
        expect(response.quest).to eq(quest)
      end
    end
  end
end
