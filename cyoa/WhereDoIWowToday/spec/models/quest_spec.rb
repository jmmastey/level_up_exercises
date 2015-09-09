require 'rails_helper'

NO_QUEST_ERROR = {"status": "nok",
                  "reason": "unable to get quest information."}.
                 to_json

RSpec.describe Quest, type: :model do
  describe ".refresh" do
      
    context "when the quest table is empty" do
      it "should fetch quests from blizzard and put them in the database" do
        stub = stub_request(:get,
                            /^https:\/\/us.api.battle.net\/wow\/quest\/.*/).
               to_return(body: quest_json_factory.create(1), status: 200).
               to_return(body: quest_json_factory.create(2), status: 200).
               to_return(body: NO_QUEST_ERROR, status: 404)
        Quest.refresh
        expect(stub).to have_been_requested.times(3)
        expect(Quest.count).to eq(2)
      end
    end

    context "when the quest table data is stale" do
      before do
        Quest.create!(id: 1, blizzard_id_num: 1, updated_at: 1.month.ago)
      end

      it "should fetch quests from blizzard and put them in the database" do
        stub = stub_request(:get,
                            /^https:\/\/us.api.battle.net\/wow\/quest\/.*/).
               to_return(body: quest_json_factory.create(1), status: 200).
               to_return(body: quest_json_factory.create(2), status: 200).
               to_return(body: NO_QUEST_ERROR, status: 404)
        Quest.refresh
        expect(stub).to have_been_requested.times(3)
        expect(Quest.count).to eq(2)
      end
    end

    context "when quest table data is less than a week old" do
      before { FactoryGirl.create(:quest) }
      
      it "should not fetch quest data from blizzard" do
        stub = stub_request(:get, 
                            /^https:\/\/us.api.battle.net\/wow\/quest\/.*/)
        Quest.refresh
        expect(stub).not_to have_been_requested
      end
    end

    context "when the get request is not successful" do
      it "should not modify the database" do
        stub = stub_request(:get,
                            /^https:\/\/us.api.battle.net\/wow\/quest\/.*/).
               to_return(body: quest_json_factory.create(3), status: 500)
        Quest.refresh
        expect(stub).to have_been_requested.once
        expect(Quest.count).to eq(0)
      end
    end
  end
end

def quest_json_factory
  def create(id)
    {
      "id": id,
     "title": "Quest Number #{id}",
     "reqLevel": 77,
     "suggestedPartyMembers": 0,
     "category": "Icecrown",
     "level": 80
    }.to_json
  end
end
