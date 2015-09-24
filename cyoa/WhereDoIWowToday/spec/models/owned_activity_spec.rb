require 'rails_helper'

RSpec.describe OwnedActivity, type: :model do
  describe ".hide" do
    let(:activity) { FactoryGirl.create(:activity) }
    let(:user) { FactoryGirl.create(:user) }

    context "when a goal exists for the specified activity+user" do
      before do
        FactoryGirl.create(:owned_activity,
                           activity: activity, user: user, list_position: "1")
      end

      it "sets hidden to true" do
        OwnedActivity.hide(activity: activity, user: user)

        goal = OwnedActivity.find_by(activity: activity, user: user)
        expect(goal.hidden).to be true
      end
    end

    context "when a goal does not exist for the specified activity+user" do
      before { OwnedActivity.destroy_all }

      it "creates an owned_activity with hidden set to true" do
        OwnedActivity.hide(activity: activity, user: user)

        goal = OwnedActivity.find_by(activity: activity, user: user)
        expect(goal.hidden).to be true
      end
    end
  end

  describe ".unhide" do
    let(:user) { FactoryGirl.create(:user) }
    let(:character) { FactoryGirl.create(:character) }
    let(:zone) { FactoryGirl.create(:category, blizzard_type: "zone") }

    context "when there are relevant hidden activities" do
      before do
        activity1 = FactoryGirl.create(:activity,
                                      character: character, category: zone)
        FactoryGirl.create(:owned_activity,
                           activity: activity1, user: user, list_position: "5",
                           hidden: true)
        activity2 = FactoryGirl.create(:activity,
                                      character: character, category: zone)
        FactoryGirl.create(:owned_activity,
                           activity: activity2, user: user, list_position: nil,
                           hidden: true)
      end

      it "sets hidden to false" do
        OwnedActivity.unhide(user: user, character: character, category: zone)

        OwnedActivity.where(user: user).each do |goal|
          expect(goal.hidden).to be false
        end
      end
    end

    context "when there is a hidden activity for a different user" do
      before do
        other = FactoryGirl.create(:user)
        activity = FactoryGirl.create(:activity)
        FactoryGirl.create(:owned_activity,
                           activity: activity, user: other, hidden: true)
        end

      it "leaves hidden true" do
        OwnedActivity.unhide(user: user, character: character, category: zone)

        expect(OwnedActivity.first.hidden).to be true
      end
    end

    context "when there is a hidden activity for a different character" do
      before do
        other = FactoryGirl.create(:character)
        activity = FactoryGirl.create(:activity, character: other)
        FactoryGirl.create(:owned_activity,
                           activity: activity, user: user, hidden: true)
        end

      it "leaves hidden true" do
        OwnedActivity.unhide(user: user, character: character, category: zone)

        expect(OwnedActivity.first.hidden).to be true
      end
    end

    context "when there is a hidden activity for a different category" do
      before do
        other = FactoryGirl.create(:category)
        activity = FactoryGirl.create(
          :activity, character: character, category: other)
        FactoryGirl.create(:owned_activity,
                           activity: activity, user: user, hidden: true)
        end

      it "leaves hidden true" do
        OwnedActivity.unhide(user: user, character: character, category: zone)

        expect(OwnedActivity.first.hidden).to be true
      end
    end
  end
  
  describe ".remove_from_goals" do
    let(:activity) { FactoryGirl.create(:activity) }
    let(:user) { FactoryGirl.create(:user) }

    context "when a goal exists for the specified activity+user" do
      before do
        FactoryGirl.create(:owned_activity,
                           activity: activity, user: user, list_position: "1")
      end

      it "sets list_position to nil" do
        OwnedActivity.remove_from_goals(activity: activity, user: user)

        goal = OwnedActivity.find_by(activity: activity, user: user)
        expect(goal.list_position).to be nil
      end

      it "does not return nil" do
        result = OwnedActivity.remove_from_goals(activity: activity, user: user)

        expect(result).not_to be nil
      end
    end

    context "when a goal does not exist for the specified activity+user" do
      before { OwnedActivity.destroy_all }

      it "returns nil" do
        result = OwnedActivity.remove_from_goals(activity: activity, user: user)

        expect(result).to be nil
      end

      context "when an owned_activity that is not a goal exists for them" do
        before do
          FactoryGirl.create(:owned_activity,
                             activity: activity, user: user,
                             list_position: nil)
        end

        it "returns nil" do
          result = OwnedActivity.remove_from_goals(
            activity: activity, user: user)

          expect(result).to be nil
        end
      end

      context "when a different user has a goal for the activity" do
        before do
          other = FactoryGirl.create(:user)
          FactoryGirl.create(:owned_activity,
                             activity: activity, user: other,
                             list_position: "1")
        end

        it "does not change the list position" do
          OwnedActivity.remove_from_goals(activity: activity, user: user)

          goal = OwnedActivity.find_by(activity: activity)
          expect(goal.list_position).to eq(1)
        end

        it "returns nil" do
          result = OwnedActivity.remove_from_goals(
            activity: activity, user: user)

          expect(result).to be nil
        end
      end

      context "when the user has a goal for a different activity" do
        before do
          other = FactoryGirl.create(:activity)
          FactoryGirl.create(:owned_activity,
                             activity: other, user: user, list_position: "1")
        end

        it "does not change the list position" do
          OwnedActivity.remove_from_goals(activity: activity, user: user)

          goal = OwnedActivity.find_by(user: user)
          expect(goal.list_position).to eq(1)
        end

        it "returns nil" do
          result = OwnedActivity.remove_from_goals(
            activity: activity, user: user)

          expect(result).to be nil
        end
      end
    end

    it "returns nil if activity is nil" do
      result = OwnedActivity.remove_from_goals(activity: nil, user: user)

      expect(result).to be nil
    end
    
    it "returns nil if user is nil" do
      result = OwnedActivity.remove_from_goals(activity: activity, user: nil)

      expect(result).to be nil
    end
  end

  describe ".add_to_goals" do
    let(:activity) { FactoryGirl.create(:activity) }
    let(:user) { FactoryGirl.create(:user) }

    context "when the goal already exists for the activity+user" do
      before do
        FactoryGirl.create(:owned_activity,
                           activity: activity, user: user, list_position: "1")
      end

      it "returns nil" do
        result = OwnedActivity.add_to_goals(activity: activity, user: user)

        expect(result).to be nil
      end
    end

    context "when the goal does not exist for the activity+user" do
      before { OwnedActivity.destroy_all }

      it "creates a goal" do
        OwnedActivity.add_to_goals(activity: activity, user: user)

        goal = OwnedActivity.find_by(activity: activity, user: user)

        expect(goal.list_position).not_to be nil
      end

      context "when an owned_activity that is not a goal exists for them" do
        before do
          FactoryGirl.create(:owned_activity,
                             activity: activity, user: user, list_position: nil)
        end

        it "sets the list_position" do
          OwnedActivity.add_to_goals(activity: activity, user: user)

          goal = OwnedActivity.find_by(activity: activity, user: user)

          expect(goal.list_position).not_to be nil
        end
      end
    end

    it "returns nil if activity is nil" do
      result = OwnedActivity.add_to_goals(activity: nil, user: user)

      expect(result).to be nil
    end

    it "returns nil if user is nil" do
      result = OwnedActivity.add_to_goals(activity: activity, user: nil)

      expect(result).to be nil
    end
  end

  describe ".goals" do
    let(:user) { FactoryGirl.create(:user) }
    let(:character) { FactoryGirl.create(:character) }
    let(:zone) { FactoryGirl.create(:category, blizzard_type: "zone") }

    context "when the user has goals for the character+category" do
      before do
        2.times do
          activity = FactoryGirl.create(:activity,
                                        character: character, category: zone)
          FactoryGirl.create(:owned_activity,
                             activity: activity, user: user)
        end
      end

      it "should list the goals" do
        result = OwnedActivity.goals(
          user: user, character: character, category: zone)

        expect(result).to match_array(Activity.all)
      end
    end

    context "when the user has a goal for the character in another category" do
      let(:zone2) { FactoryGirl.create(:category, blizzard_type: "zone") }
      before do
        activity = FactoryGirl.create(:activity,
                                      character: character, category: zone2)
        FactoryGirl.create(:owned_activity, activity: activity, user: user)
      end
      
      it "should return an empty list" do
        result = OwnedActivity.goals(
          user: user, character: character, category: zone)

        expect(result).to be_empty
      end
    end

    context "when the user has a goal for another character in the category" do
      let(:character2) { FactoryGirl.create(:character) }
      before do
        activity = FactoryGirl.create(:activity,
                                      character: character2, category: zone)
        FactoryGirl.create(:owned_activity, activity: activity, user: user)
      end

      it "should return an empty list" do
        result = OwnedActivity.goals(
          user: user, character: character, category: zone)

        expect(result).to be_empty
      end
    end

    context "when a different user has a goal for the character+category" do
      let(:user2) { FactoryGirl.create(:user) }
      before do
        activity = FactoryGirl.create(:activity,
                                      character: character, category: zone)
        FactoryGirl.create(:owned_activity, activity: activity, user: user2)
      end

      it "should return an empty list" do
        result = OwnedActivity.goals(
          user: user, character: character, category: zone)

        expect(result).to be_empty
      end
    end

    context "when a goal exists" do
      before do
        activity = FactoryGirl.create(:activity,
                                      character: character, category: zone)
        FactoryGirl.create(:owned_activity, activity: activity, user: user)
      end

      it "returns an empty list if user is nil" do
        result = OwnedActivity.goals(
          user: nil, character: character, category: zone)

        expect(result).to be_empty
      end

      it "returns an empty list if character is nil" do
        result = OwnedActivity.goals(
          user: user, character: nil, category: zone)

        expect(result).to be_empty
      end

      it "returns an empty list if category is nil" do
        result = OwnedActivity.goals(
          user: user, character: character, category: nil)

        expect(result).to be_empty
      end
    end

    context "when the goal is hidden" do
      before do
        activity = FactoryGirl.create(:activity,
                                      character: character, category: zone)
        FactoryGirl.create(:owned_activity,
                           activity: activity, user: user, hidden: true)
      end

      it "returns an empty list" do
        result = OwnedActivity.goals(
          user: user, character: character, category: zone)

        expect(result).to be_empty
      end
    end
  end
  
  describe ".hidden_activities" do
    let(:user) { FactoryGirl.create(:user) }
    let(:character) { FactoryGirl.create(:character) }
    let(:zone) { FactoryGirl.create(:category, blizzard_type: "zone") }

    context "when there is a hidden activity for the user+character+category" do
      let!(:activity) do
        FactoryGirl.create(:activity, character: character, category: zone)
      end
      let!(:owned_activity) do
        FactoryGirl.create(:owned_activity,
                           activity: activity, user: user, hidden: true)
      end

      it "returns an empty list if user is nil" do
        result = OwnedActivity.hidden_activities(
          user: nil, character: character, category: zone)

        expect(result).to be_empty
      end

      it "returns an empty list if character is nil" do
        result = OwnedActivity.hidden_activities(
          user: user, character: nil, category: zone)

        expect(result).to be_empty
      end

      it "returns an empty list if category is nil" do
        result = OwnedActivity.hidden_activities(
          user: user, character: character, category: nil)

        expect(result).to be_empty
      end

      context "when it is a goal" do
        before do
          owned_activity.list_position = 10
          owned_activity.save
        end

        it "returns a list containing the activity" do
          result = OwnedActivity.hidden_activities(
            character: character, user: user, category: zone)

          expect(result).to match_array([activity])
        end
      end

      context "when it is not a goal" do
        before do
          owned_activity.list_position = nil
          owned_activity.save
        end


        it "returns a list containing the activity" do
          result = OwnedActivity.hidden_activities(
            character: character, user: user, category: zone)

          expect(result).to match_array([activity])
        end
      end
    end

    context "when the activity is not hidden for the user+character+category" do
      before do
        activity = FactoryGirl.create(:activity,
                                      character: character, category: zone)
        FactoryGirl.create(:owned_activity, activity: activity, user: user)
      end

      it "returns an empty list" do
          result = OwnedActivity.hidden_activities(
            character: character, user: user, category: zone)

          expect(result).to be_empty
      end
    end
  end
end
