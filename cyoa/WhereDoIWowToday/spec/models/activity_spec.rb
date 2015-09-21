require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe "#find_or_create" do
    context "when the activity exists" do
      let(:activity) { FactoryGirl.create(:activity, :quest) }

      it "returns the activity" do
        response = Activity.find_or_create(
          character: activity.character,
          category: activity.category,
          quest: activity.quest,
        )

        expect(response).to eq(activity)
      end
    end

    context "when the activity does not exist" do
      before { Activity.destroy_all }

      it "returns a newly created activity" do
        character = FactoryGirl.create(:character)
        quest = FactoryGirl.create(:quest)
        category = FactoryGirl.create(:category)

        response = Activity.find_or_create(
          character: character, category: category, quest: quest)

        expect(Activity.count).to eq(1)
        expect(response.character).to eq(character)
        expect(response.category).to eq(category)
        expect(response.quest).to eq(quest)
      end
    end
  end

  describe "#zone" do
    let(:activity) { FactoryGirl.create :activity }

    it "should be equivalent to category" do
      expect(activity.zone).to eq(activity.category)
    end
  end

  describe "#hide" do
    let(:activity) { FactoryGirl.create :activity, hidden: false }

    it "should set hidden to true" do
      activity.hide
      expect(activity.hidden).to be(true)
    end
  end

  describe "#unhide" do
    let(:activity) { FactoryGirl.create :activity, hidden: true }

    it "should set hidden to false" do
      activity.unhide
      expect(activity.hidden).to be(false)
    end
  end
end
