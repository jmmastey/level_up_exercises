require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  describe "#goals" do
    context "when the user has goals" do
      let!(:goal1) { FactoryGirl.create(:owned_activity, :goal, user: user) }
      let!(:goal2) { FactoryGirl.create(:owned_activity, :goal, user: user) }

      it "returns the goal activities as a list" do
        expect(user.goals).to match_array([goal1.activity, goal2.activity])
      end

      context "when the character is specified" do
        it "returns the goals that match the character" do
          result = user.goals(character_id: goal1.activity.character.id)

          expect(result).to eq([goal1.activity])
        end
      end

      context "when the category is specified" do
        let!(:category) { FactoryGirl.create(:category) }
        let!(:activity3) { FactoryGirl.create(:activity, category: category) }
        let!(:goal3) do
          FactoryGirl.create(
            :owned_activity, :goal, user: user, activity: activity3)
        end

        it "returns the goals that match the category" do
          result = user.goals(category_id: category.id)

          expect(result).to eq([activity3])
        end
      end
    end

    context "when the user does not have goals" do
      it "returns an empty list" do
        expect(user.goals).to be_empty
      end
    end

    context "when the user has activities that are not goals" do
      let!(:non_goal) { FactoryGirl.create(:owned_activity, user: user) }

      it "returns an empty list" do
        expect(user.goals).to be_empty
      end
    end

    context "when an invalid argument is specified" do
      it "raises an error" do
        expect { user.goals(thing: "thing") }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#available_activities" do
    context "when the activities table is empty" do
      before { Activity.destroy_all }

      it "returns an empty list" do
        expect(user.available_activities).to be_empty
      end
    end

    context "when there is an activity not tied to any user" do
      let!(:activity) { FactoryGirl.create(:activity) }

      it "returns the unowned_activity as a list" do
        expect(user.available_activities).to match_array([activity])
      end

      context "when the user owns an available version of that activity" do
        let!(:owned_activity) do
          FactoryGirl.create(:owned_activity, user: user, activity: activity)
        end

        it "returns the activity as a list" do
          expect(user.available_activities).to match_array([activity])
        end
      end
    end

    context "when the user has showable activities that are not goals" do
      let(:activity1) { FactoryGirl.create(:activity) }
      let!(:non_goal1) do
        FactoryGirl.create(:owned_activity, user: user, activity: activity1)
      end
      let(:activity2) { FactoryGirl.create(:activity) }
      let!(:non_goal2) do
        FactoryGirl.create(:owned_activity, user: user, activity: activity2)
      end

      it "returns the activities as a list" do
        expect(user.available_activities).to eq([activity1, activity2])
      end

      context "when the character is specified" do
        it "returns the activities that match the character" do
          character_id = activity1.character.id
          result = user.available_activities(character_id: character_id)

          expect(result).to match_array([activity1])
        end
      end

      context "when the category is specified" do
        let(:category) { FactoryGirl.create(:category) }
        let(:activity3) { FactoryGirl.create(:activity, category: category) }
        let!(:non_goal3) do
          FactoryGirl.create(:owned_activity, user: user, activity: activity3)
        end

        it "returns the activities that match the category" do
          result = user.available_activities(category_id: category.id)

          expect(result).to eq([activity3])
        end
      end
    end

    context "when the user has hidden activities that are not goals" do
      let!(:owned_activity) do
        FactoryGirl.create(:owned_activity, hidden: true, user: user)
      end

      it "returns an empty list" do
        expect(user.available_activities).to be_empty
      end
    end

    context "when the user has goals" do
      before { FactoryGirl.create(:owned_activity, :goal, user: user) }

      it "returns an empty list" do
        expect(user.available_activities).to be_empty
      end
    end

    context "when an invalid argument is specified" do
      it "raises an error" do
        expect { user.available_activities(thing: "thing") }
          .to raise_error(ArgumentError)
      end
    end
  end

  describe "#add_to_goals" do
    context "when a non-goal owned_activity exists for the activity" do
      let!(:activity) { FactoryGirl.create(:activity) }
      let!(:owned_activity) do
        FactoryGirl.create(:owned_activity, activity: activity, user: user)
      end

      it "should make the owned_activity a goal" do
        user.add_to_goals(activity)

        owned = OwnedActivity.find_by(user: user, activity: activity)
        expect(owned).to be_goal
      end
    end

    context "when the activity is already a goal" do
      let!(:activity) { FactoryGirl.create(:activity) }
      let!(:existing_goal) do
        FactoryGirl.create(
          :owned_activity, :goal, activity: activity, user: user)
      end

      it "should leave the goal alone" do
        user.add_to_goals(activity)

        owned = OwnedActivity.find_by(user: user, activity: activity)
        expect(owned).to be_goal
      end
    end

    context "when the activity is not yet tied to the user" do
      let!(:activity) { FactoryGirl.create(:activity) }

      it "creates a new owned_activity with the activity as a user goal" do
        user.add_to_goals(activity)

        owned = OwnedActivity.find_by(user: user, activity: activity)
        expect(owned).to be_goal
      end
    end
  end

  describe "#remove_from_goals" do
    context "when the owned_activity is not a goal" do
      let!(:activity) { FactoryGirl.create(:activity) }
      let!(:owned_activity) do
        FactoryGirl.create(:owned_activity, activity: activity, user: user)
      end

      context "when there are no goals" do
        it "does not raise an error" do
          expect { user.remove_from_goals(activity) }.not_to raise_error
        end
      end

      context "when there is an existing goal" do
        let!(:existing_goal) do
          FactoryGirl.create(:owned_activity, :goal, user: user)
        end

        it "the existing goal is left a goal" do
          existing_id = existing_goal.id

          user.remove_from_goals(activity)

          owned_activity = OwnedActivity.find(existing_id)
          expect(owned_activity).to be_goal
        end
      end
    end

    context "when the activity is a goal" do
      let!(:activity) { FactoryGirl.create(:activity) }
      let!(:existing_goal) do
        FactoryGirl.create(
          :owned_activity, :goal, activity: activity, user: user)
      end

      it "makes the activity not a goal" do
        existing_id = existing_goal.id
        user.remove_from_goals(activity)

        owned_activity = OwnedActivity.find_by(id: existing_id)
        expect(owned_activity).not_to be_goal
      end
    end
  end

  describe "#hide" do
    context "when the user has an owned_activity for the activity" do
      let!(:activity) { FactoryGirl.create(:activity) }
      let!(:owned_activity) do
        FactoryGirl.create(
          :owned_activity, activity: activity, user: user, hidden: false)
      end

      it "hides the activity" do
        id = owned_activity.id

        user.hide(activity)

        owned_activity = OwnedActivity.find(id)
        expect(owned_activity).not_to be_showable
      end
    end

    context "when the user does not have an owned_activity for the activity" do
      let!(:activity) { FactoryGirl.create(:activity) }

      it "creates a new hidden owned_activity" do
        user.hide(activity)

        owned_activity = OwnedActivity.find_by(activity: activity)
        expect(owned_activity).not_to be_showable
      end
    end
  end

  describe "#unhide_all" do
    context "when the user has hidden owned_activities" do
      let!(:character1) { FactoryGirl.create(:character) }
      let!(:character2) { FactoryGirl.create(:character) }
      let!(:category1) { FactoryGirl.create(:category) }
      let!(:category2) { FactoryGirl.create(:category) }
      let!(:activity1) do
        FactoryGirl.create(
          :activity, character: character1, category: category1)
      end
      let!(:activity2) do
        FactoryGirl.create(
          :activity, character: character2, category: category1)
      end
      let!(:activity3) do
        FactoryGirl.create(
          :activity, character: character1, category: category2)
      end
      before do
        FactoryGirl.create(
          :owned_activity, activity: activity1, user: user, hidden: true)
        FactoryGirl.create(
          :owned_activity, activity: activity2, user: user, hidden: true)
        FactoryGirl.create(
          :owned_activity, activity: activity3, user: user, hidden: true)
      end

      it "makes all of the user's owned_activities showable" do
        user.unhide_all

        user.owned_activities.each do |owned_activity|
          expect(owned_activity).to be_showable
        end
      end

      context "when the character is specified" do
        it "makes the user+character owned_activites showable" do
          user.unhide_all(character_id: character1.id)

          expect(OwnedActivity.find_by(activity: activity1)).to be_showable
          expect(OwnedActivity.find_by(activity: activity2)).not_to be_showable
          expect(OwnedActivity.find_by(activity: activity3)).to be_showable
        end
      end

      context "when the category is specified" do
        it "makes the user+category owned_activites showable" do
          user.unhide_all(category_id: category1.id)

          expect(OwnedActivity.find_by(activity: activity1)).to be_showable
          expect(OwnedActivity.find_by(activity: activity2)).to be_showable
          expect(OwnedActivity.find_by(activity: activity3)).not_to be_showable
        end
      end
    end

    context "when the user does not have hidden owned_activities" do
      it "does not raise an error" do
        expect { user.unhide_all }.not_to raise_error
      end
    end

    context "when an invalid argument is specified" do
      it "raises an error" do
        expect { user.unhide_all(thing: "thing") }
          .to raise_error(ArgumentError)
      end
    end
  end
end
