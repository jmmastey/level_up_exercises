require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe "#zone" do
    let(:activity) { FactoryGirl.create :activity }

    it "should be equivalent to category" do
      expect(activity.zone).to eq(activity.category)
    end
  end

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
end
