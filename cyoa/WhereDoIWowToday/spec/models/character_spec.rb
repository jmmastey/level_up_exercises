require 'rails_helper'

RSpec.describe Character, type: :model do
  describe "validations" do
  end

  describe ".refresh_individual" do
    context "when the character is not in the database" do
      before { Character.destroy_all }

      it "should fetch the character's data from blizzard and store it" do
        stub_character_api("Sal", "Earthen Ring")

        Character.refresh_individual(name: "Sal", realm: "Earthen Ring")

        expect(Character.count).to eq(1)
        expect(Character.find_by_name("Sal").realm).to eq("Earthen Ring")
      end
    end

    context "when the character data is stale" do
      before do
        FactoryGirl.create(:character, name: "Cris", realm: "Earthen Ring",
                           updated_at: 2.days.ago)
      end

      it "should fetch the character's data from blizzard and store it" do
        stub = stub_character_api("Cris", "Earthen Ring")

        Character.refresh_individual(name: "Cris", realm: "Earthen Ring")

        expect(stub).to have_been_requested.once
        expect(Character.count).to eq(1)
        expect(Character.find_by_name("Cris").realm).to eq("Earthen Ring")
      end
    end

    context "when the character data is recent" do
      before do
        FactoryGirl.create(:character, name: "Sam", realm: "Earthen Ring",
                           updated_at: 2.minutes.ago)
      end

      it "should not fetch the character's data from blizzard" do
        stub = stub_character_api("Sam", "Earthen Ring")

        Character.refresh_individual(name: "Sam", realm: "Earthen Ring")

        expect(stub).not_to have_been_requested
      end
    end
  end

  describe "#update_dependents" do
    let(:raw_data) { RawCharacterDataFactory.create("Sam", "Earthen Ring") }
    let(:character) do
      FactoryGirl.create(:character, name: "Sal", realm: "Argent Dawn")
    end

    before do
      [100, 101, 201].each do |id|
        FactoryGirl.create(:quest, blizzard_id_num: id)
      end
    end

    context "when the character is new" do
      context "when the character has not completed 2 of 3 quests" do
        it "should create an activity for each uncompleted quest" do
          Activity.destroy_all

          character.update_dependents(raw_data)

          quests = Activity.all.map(&:quest)
          expect(quests.map(&:blizzard_id_num)).to match_array([101, 201])
        end
      end
    end

    context "when the character already has activities" do
      let!(:quest) { Quest.find_by(blizzard_id_num: 101) }
      let!(:existing_activity) do
        FactoryGirl.create(:activity, character: character,
                           quest: quest)
      end

      it "does not create a duplicate activity" do
        character.update_dependents(raw_data)

        expect(Activity.count).to eq(2)
      end
    end

    context "when the character has newly completed a quest" do
      let!(:quest) { Quest.find_by(blizzard_id_num: 100) }
      let!(:existing_activity) do
        FactoryGirl.create(:activity, character: character,
                           quest: quest)
      end

      it "removes the obsolete activity" do
        character.update_dependents(raw_data)

        character_activities = Activity.where(character: character)
        character_quests = character_activities.map(&:quest)
        expected_quests = [Quest.find_by(blizzard_id_num: 101),
                           Quest.find_by(blizzard_id_num: 201)]
        expect(character_quests).to match_array(expected_quests)
      end
    end
  end

  describe "#zone_summaries" do
    let(:character) { FactoryGirl.create(:character) }

    context "when the character does not have activities" do
      before { Activity.destroy_all }

      it "should have an empty return value" do
        expect(character.zone_summaries).to be_empty
      end
    end

    context "when the character has activities" do
      before do
        3.times do
          FactoryGirl.create(
            :activity, character: character, category_name: "Duskwood")
        end
        2.times do
          FactoryGirl.create(
            :activity, character: character, category_name: "Ashenvale")
        end
      end

      it "should return a summary for each zone" do
        expect(character.zone_summaries.count).to eq(2)
        expect(character.zone_summaries).to have_key("Duskwood")
        expect(character.zone_summaries).to have_key("Ashenvale")
      end

      it "should include the category id in the summary" do
        duskwood_summary = character.zone_summaries["Duskwood"]
        duskwood = Category.find_by_name("Duskwood")
        expect(duskwood_summary[:id]).to eq(duskwood.id)
      end
    end
  end
end

def stub_character_api(name, realm)
  raw_data = RawCharacterDataFactory.create(name, realm)
  body = raw_data.to_json
  stub_request(:any, /character/).to_return(body: body, status: 200)
end

module RawCharacterDataFactory
  def self.create(name, realm)
    {
      "name" => name,
      "realm" => realm,
      "race" => 3,
      "level" => 100,
      "quests" => [100, 171, 107],
    }
  end
end
