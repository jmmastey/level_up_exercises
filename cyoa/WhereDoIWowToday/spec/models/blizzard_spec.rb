require 'rails_helper'

RSpec.describe Blizzard, type: :model do
  let(:api) { Blizzard.new }
  describe "#get_character" do
    let(:url_pattern) { %r{character/Earthen%20Ring/Nell\?apikey=.*} }

    it "should retrieve character information from battlenet" do
      stub_request(:get, url_pattern)
        .to_return(body: { name: "Nell", realm: "Earthen Ring" }.to_json)

      character = api.get_character("Nell", "Earthen Ring")

      expect(character["name"]).to eq("Nell")
    end

    it "should return nil if there was an error"do
      stub_request(:get, %r{character/Earthen%20Ring/Nell\?apikey=.*})
        .to_return(body: { name: "Nell" }.to_json, status: 500)

      character = api.get_character("Nell", "Earthen Ring")

      expect(character).to be_nil
    end
  end

  describe "#get_character_quests" do
    let(:url_patterns) do
      [%r{character/Earthen%20Ring/Nell\?apikey=.*&fields=quests},
       %r{character/Earthen%20Ring/Nell\?fields=quests&apikey=.*}]
    end

    it "should retrieve the character's completed quests list from battlenet" do
      url_patterns.each do |url_pattern|
        stub_request(:get, url_pattern)
          .to_return(body: { name: "Nell", quests: [1, 171, 107] }.to_json)
      end

      response = api.get_character_quests("Nell", "Earthen Ring")

      expect(response["quests"]).to match_array([1, 171, 107])
    end

    it "should return nil if there was an error"do
      url_patterns.each do |url_pattern|
        stub_request(:get, url_pattern)
          .to_return(body: { name: "Nell" }.to_json, status: 500)
      end

      response = api.get_character_quests("Nell", "Earthen Ring")

      expect(response).to be_nil
    end
  end

  describe "#get_quest" do
    let(:url_pattern) { %r{^https://us.api.battle.net/wow/quest/.*\?apikey=.} }

    it "should retrieve quest information from battlenet" do
      stub_request(:get, url_pattern)
        .to_return(body: { title: "A quest" }.to_json)

      quest = api.get_quest(15)

      expect(quest["title"]).to eq("A quest")
    end

    it "should return nil if there was an error"do
      stub_request(:get, url_pattern)
        .to_return(body: { title: "A quest" }.to_json, status: 404)

      quest = api.get_quest(15)

      expect(quest).to be_nil
    end
  end

  describe "#get_realm_status" do
    let(:url_pattern) { %r{us.api.battle.net/wow/realm/status\?apikey=.} }
    let(:realm_statuses) { IO.read("spec/test_data/realm_status_body.txt") }

    it "should retrieve realm status information from battlenet" do
      stub_request(:get, url_pattern)
        .to_return(body: realm_statuses, status: 200)

      statuses = api.get_realm_status

      realms = statuses["realms"]
      expect(realms.length).to eq(2)
    end

    it "should return nil if there was an error"do
      stub_request(:get, url_pattern)
        .to_return(body: realm_statuses, status: 404)

      realms = api.get_realm_status

      expect(realms).to be_nil
    end
  end
end
