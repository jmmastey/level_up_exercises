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
end
