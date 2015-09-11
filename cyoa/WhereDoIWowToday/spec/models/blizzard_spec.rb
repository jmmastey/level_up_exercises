require 'rails_helper'

RSpec.describe Blizzard, type: :model do
  describe "#get_character" do
    let(:api) { Blizzard.new }
    let(:url_pattern) { /character\/Earthen%20Ring\/Nell\?apikey=.*/ }
    
    it "should retrieve character information from battlenet" do
      stub_request(:get, url_pattern).
        to_return(body: { name: "Nell", realm: "Earthen Ring" }.to_json)

      character = api.get_character("Nell", "Earthen Ring")

      expect(character["name"]).to eq("Nell")
    end

    it "should return nil if there was an error"do
      stub_request(:get, /character\/Earthen%20Ring\/Nell\?apikey=.*/).
             to_return(body: { name: "Nell" }.to_json, status: 500)

      character = api.get_character("Nell", "Earthen Ring")

      expect(character).to be_nil
    end
  end
  
  describe "#get_character_quests" do
    let(:api) { Blizzard.new }
    let(:url_patterns) do
      [/character\/Earthen%20Ring\/Nell\?apikey=.*&fields=quests/,
       /character\/Earthen%20Ring\/Nell\?fields=quests&apikey=.*/]
    end
    
    it "should retrieve the character's completed quests list from battlenet" do
      url_patterns.each do |url_pattern|
        stub_request(:get, url_pattern).
          to_return(body: { name: "Nell", quests: [1, 171, 107] }.to_json)
      end

      response = api.get_character_quests("Nell", "Earthen Ring")

      expect(response["quests"]).to match_array([1, 171, 107])
    end

    it "should return nil if there was an error"do
      url_patterns.each do |url_pattern|
        stub_request(:get, url_pattern).
          to_return(body: { name: "Nell" }.to_json, status: 500)
      end
      
      response = api.get_character_quests("Nell", "Earthen Ring")

      expect(response).to be_nil
    end
  end

  describe "#get_quest" do
    let(:api) { Blizzard.new }
    let(:url_pattern) { /^https:\/\/us.api.battle.net\/wow\/quest\/.*/ }
    
    it "should retrieve quest information from battlenet" do
      stub_request(:get, url_pattern).
        to_return(body: { title: "A quest" }.to_json)

      quest = api.get_quest(15)

      expect(quest["title"]).to eq("A quest")
    end

    it "should return nil if there was an error"do
      stub_request(:get, url_pattern).
        to_return(body: { title: "A quest" }.to_json, status: 404)

      quest = api.get_quest(15)

      expect(quest).to be_nil
    end
  end
end
