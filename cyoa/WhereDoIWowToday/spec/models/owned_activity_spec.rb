require 'rails_helper'

RSpec.describe OwnedActivity, type: :model do
  let(:activity) { FactoryGirl.create(:activity) }

  describe ".create_goal" do
    let(:user) { FactoryGirl.create(:user) }

    it "should return a new goal for the user+activity" do
      result = OwnedActivity.create_goal(user, activity)

      expect(result).to be_goal
      expect(result.user).to eq(user)
      expect(result.activity).to eq(activity)
    end

    it "should save the goal in the database" do
      OwnedActivity.create_goal(user, activity)
      expect(OwnedActivity.count).to eq(1)
    end

    context "when a goal already exists for the user" do
      let!(:old_goal) { FactoryGirl.create(:owned_activity, :goal, user: user) }

      it "should give the new goal the next available index" do
        result = OwnedActivity.create_goal(user, activity)

        expect(result.index).to eq(old_goal.index + 1)
      end
    end
  end

  describe "#showable?" do
    context "when the hidden attribute is true" do
      let(:owned) { FactoryGirl.create(:owned_activity, hidden: true) }

      it { expect(owned.showable?).to be false }
    end

    context "when the hidden attribute is false" do
      let(:owned) { FactoryGirl.create(:owned_activity, hidden: false) }

      it { expect(owned.showable?).to be true }
    end
  end

  describe "#goal?" do
    context "when the index attribute is nil" do
      let(:owned) { FactoryGirl.create(:owned_activity, index: nil) }

      it { expect(owned.goal?).to be false }
    end

    context "when the index attribute is not nil" do
      let(:owned) { FactoryGirl.create(:owned_activity, index: "3") }

      it { expect(owned.goal?).to be true }
    end
  end

  describe "#hide" do
    context "when hidden is false" do
      let(:owned) { FactoryGirl.create(:owned_activity, hidden: false) }

      it "should set hidden to true" do
        owned.hide

        expect(OwnedActivity.first.hidden).to be true
      end
    end

    context "when hidden is true" do
      let(:owned) { FactoryGirl.create(:owned_activity, hidden: true) }

      it "should leave hidden true" do
        owned.hide

        expect(OwnedActivity.first.hidden).to be true
      end
    end
  end

  describe "#unhide" do
    context "when hidden is true" do
      let(:owned) { FactoryGirl.create(:owned_activity, hidden: true) }

      it "should set hidden to false" do
        owned.unhide

        expect(OwnedActivity.first.hidden).to be false
      end
    end

    context "when hidden is false" do
      let(:owned) { FactoryGirl.create(:owned_activity, hidden: false) }

      it "leave hidden false" do
        owned.unhide

        expect(OwnedActivity.first.hidden).to be false
      end
    end
  end

  describe ".make_not_goal" do
    context "when the owned_activity is a goal" do
      let(:owned) { FactoryGirl.create(:owned_activity, :goal) }

      it "should make the owned activity be not a goal" do
        id = owned.id
      
        owned.make_not_goal

        expect(OwnedActivity.find(id)).not_to be_goal
      end
    end

    context "when the owned_activity is not a goal" do
      let(:owned) { FactoryGirl.create(:owned_activity) }

      it "should leave the owned activity not a goal" do
        id = owned.id
      
        owned.make_not_goal

        expect(OwnedActivity.find(id)).not_to be_goal
      end
    end
  end

  describe ".convert_to_goal" do
    let(:user) { FactoryGirl.create(:user) }

    context "when the user has a goal" do
      let!(:goal) { FactoryGirl.create(:owned_activity, :goal, user: user) }
      let!(:owned_activity) { FactoryGirl.create(:owned_activity, user: user) }

      it "should make the owned_activity a goal" do
        id = owned_activity.id

        owned_activity.convert_to_goal

        expect(OwnedActivity.find(id)).to be_goal
      end

      it "should give the new goal the next available index" do
        old_goal_index = goal.index
        id = owned_activity.id

        owned_activity.convert_to_goal

        expect(OwnedActivity.find(id).index).to eq(old_goal_index + 1)
      end
    end

    context "when the user does not have a goal" do
      let!(:owned_activity) { FactoryGirl.create(:owned_activity, user: user) }

      it "should give the new goal an index of 1" do
        id = owned_activity.id

        owned_activity.convert_to_goal

        expect(OwnedActivity.find(id).index).to eq(1)
      end
    end
  end
end
