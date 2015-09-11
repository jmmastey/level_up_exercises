require 'rails_helper'

RSpec.describe Character, type: :model do
  describe ".refresh_individual" do
    context "when the character is not in the database" do
      before { Character.destroy_all }

      it "should fetch the character's data from blizzard and store it" do
        json_body = character_json_factory.create("Sal", "Earthen Ring")
        stub = stub_request(:any, //).to_return(body: json_body, status: 200)

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
        json_body = character_json_factory.create("Cris", "Earthen Ring")
        stub = stub_request(:any, //).to_return(body: json_body, status: 200)

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
        json_body = character_json_factory.create("Sam", "Earthen Ring")
        stub = stub_request(:any, //).to_return(body: json_body, status: 200)

        Character.refresh_individual(name: "Sam", realm: "Earthen Ring")

        expect(stub).not_to have_been_requested
      end
    end
  end

  describe "#update_dependents" do
    context "when the character is new" do
      let(:character) do
        FactoryGirl.create(:character, name: "Sal", realm: "Argent Dawn")
      end
      let(:json_body) { character_json_factory.create("Sal", "Argent Dawn") }
      
      context "when there are 2 quests the character has not completed" do
        before do
          [100, 101, 201].each do |id|
            FactoryGirl.create(:quest, blizzard_id_num: id)
          end
        end

        it "should create a character_zone_activity for each quest" do
          CharacterZoneActivity.destroy_all
          stub_request(:any, //).to_return(body: json_body, status: 200)
          
          character.update_dependents(JSON.parse(json_body))
          
          expect(CharacterZoneActivity.count).to eq(2)
        end
      end
    end
  end

  describe "#zone_summaries" do
    let(:character) { FactoryGirl.create(:character) }

    context "when the character does not have character_zone_activities" do
      it "should have an empty return value" do
        expect(character.zone_summaries).to be_empty
      end
    end

    context "when the character has character_zone_activities" do
      before do
        3.times do
          FactoryGirl.create(:character_zone_activity, :quest,
                             character: character, category_name: "Duskwood")
        end
        2.times do
          FactoryGirl.create(:character_zone_activity, :quest,
                             character: character, category_name: "Ashenvale")
        end
      end
      
      it "should return a summary for each character_zone_activity" do
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

def character_json_factory
  def create(name, realm)
    {
     "lastModified": 1439777849000,
     "name": name,
     "realm": realm,
     "battlegroup": "Vindication",
     "class": 2,
     "race": 3,
     "gender": 1,
     "level": 100,
     "achievementPoints": 16520,
     "thumbnail": "earthen-ring/133/4118149-avatar.jpg",
     "calcClass": "b",
     "quests": [100, 171, 107],
     "totalHonorableKills": 2271,
    }.to_json
  end
end
