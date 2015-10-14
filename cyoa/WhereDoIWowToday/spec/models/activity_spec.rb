require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe "it should not save invalid activities" do
    let(:character) { FactoryGirl.create(:character) }
    let(:category) { FactoryGirl.create(:category) }
    let(:quest) { FactoryGirl.create(:quest) }

    it "should save an activity with a character, category, and quest" do
      activity = Activity.new(
        character: character, category: category, quest: quest)

      activity.save

      expect(Activity.all).to match_array([activity])
    end

    it "should not save an activity without a character" do
      activity = Activity.new(category: category, quest: quest)

      activity.save

      expect(Activity.all).to be_empty
    end

    it "should not save an activity without a caregory" do
      activity = Activity.new(character: character, quest: quest)

      activity.save

      expect(Activity.all).to be_empty
    end

    it "should not save an activity without a quest" do
      activity = Activity.new(character: character, category: category)

      activity.save

      expect(Activity.all).to be_empty
    end

    it "should not save a duplicate activity" do
      activity1 = Activity.new(
        character: character, category: category, quest: quest)
      activity2 = Activity.new(
        character: character, category: category, quest: quest)

      activity1.save
      activity2.save

      expect(Activity.all).to match_array([activity1])
    end
  end

  describe "#find_or_create" do
    context "when the activity exists" do
      let(:activity) { FactoryGirl.create(:activity) }

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
end
