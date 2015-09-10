require 'rails_helper'

RSpec.describe Blizzard, type: :model do
  describe "#get_character" do
    let(:api) { Blizzard.new }
    
    it "should retrieve character information from battlenet" do
      stub = stub_request(:get, /character\/Earthen%20Ring\/Nell\?apikey=.*/).
             to_return(body: { name: "Nell", realm: "Earthen Ring" }.to_json)

      character = api.get_character("Nell", "Earthen Ring")

      expect(character["name"]).to eq("Nell")
    end

    it "should return nil if there was an error"do
      stub = stub_request(:get, /character\/Earthen%20Ring\/Nell\?apikey=.*/).
             to_return(body: { name: "Nell" }.to_json, status: 500)

      character = api.get_character("Nell", "Earthen Ring")

      expect(character).to be_nil
    end

    describe "#get_quest" do
      it "should retrieve quest information from battlenet" do
        stub = stub_request(:get,
                            /^https:\/\/us.api.battle.net\/wow\/quest\/.*/).
               to_return(body: { title: "A quest" }.to_json)

        quest = api.get_quest(15)

        expect(quest["title"]).to eq("A quest")
      end
    end

    it "should return nil if there was an error"do
        stub = stub_request(:get,
                            /^https:\/\/us.api.battle.net\/wow\/quest\/.*/).
               to_return(body: { title: "A quest" }.to_json, status: 404)

        quest = api.get_quest(15)

        expect(quest).to be_nil
    end
end
end
