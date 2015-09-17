require 'rails_helper'

NO_QUEST_ERROR = { "status": "nok",
                   "reason": "unable to get quest information." }
                 .to_json

RSpec.describe Quest, type: :model do
  it "should not save a quest without a title" do
    quest = Quest.new(id: 5, blizzard_id_num: 2)

    quest.save

    expect(Quest.all).to be_empty
  end

  it "should not save a quest without a blizzard_id_num" do
    quest = Quest.new(id: 5, title: "A quest")

    quest.save

    expect(Quest.all).to be_empty
  end

  describe ".populate_next_batch" do
    context "when the highest blizzard quest id in the database is 10" do
      before do
        Quest.create!(blizzard_id_num: 10, id: 15, title: "A quest")
      end

      it "should start getting quests at blizzard id 11" do
        stub_10 = stub_request(:get, %r{quest/10})
        stub_11 = stub_request(:get, %r{quest/11})

        Quest.populate_next_batch(count: 1)

        expect(stub_10).not_to have_been_requested
        expect(stub_11).to have_been_requested.times(1)
      end
    end

    it "should get the specified number of quests" do
      stub = stub_request(:get, /quest/)

      Quest.populate_next_batch(count: 10)

      expect(stub).to have_been_requested.times(10)
    end

    it "should not get quests if the specified number is less than 1" do
      stub = stub_request(:get, /quest/)

      Quest.populate_next_batch(count: 0)
      Quest.populate_next_batch(count: -1)

      expect(stub).not_to have_been_requested
    end
  end

  describe ".populate_from_blizzard" do
    it "should fetch quests from blizzard and put them in the database" do
      stub = stub_request(:any, /quest/)
             .to_return(body: QuestJsonFactory.create(1), status: 200)
             .to_return(body: QuestJsonFactory.create(2), status: 200)

      Quest.populate_from_blizzard(min_blizzard_id: 1, max_blizzard_id: 2)

      expect(stub).to have_been_requested.times(2)
      expect(Quest.count).to eq(2)
    end

    it "should populate each quest correctly" do
      stub_request(:any, /quest/)
        .to_return(body: QuestJsonFactory.create(1), status: 200)

      Quest.populate_from_blizzard(min_blizzard_id: 1, max_blizzard_id: 1)
      quest = Quest.last

      expect(quest.id).not_to be_nil
      expect(quest.blizzard_id_num).to eq(1)
      expect(quest.title).to eq("Quest Number 1")
      expect(quest.req_level).to eq(77)
      expect(quest.level).to eq(80)
      expect(quest.categories)
        .to match_array(Category.find_by(name: "Icecrown"))
    end

    it "should not create a database entry for a bad response" do
      stub = stub_request(:any, /quest/)
             .to_return(body: NO_QUEST_ERROR, status: 404)

      Quest.populate_from_blizzard(min_blizzard_id: 1, max_blizzard_id: 1)

      expect(stub).to have_been_requested.once
      expect(Quest.count).to eq(0)
    end
  end
end

module QuestJsonFactory
  def self.create(id)
    {
      "id": id,
      "title": "Quest Number #{id}",
      "reqLevel": 77,
      "category": "Icecrown",
      "level": 80,
    }.to_json
  end
end
