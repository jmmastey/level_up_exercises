require 'rails_helper'

RSpec.describe Realm, type: :model do
  describe ".name_for_url" do
    it "should return the slug" do
      Realm.create(name: "Earthen Ring", slug: "earthen-ring")
      result = Realm.name_for_url("Earthen Ring")
      expect(result).to eq("earthen-ring")
    end
  end
  
  describe ".refresh" do
    let(:realm_statuses) { IO.read("spec/test_data/realm_status_body.txt") }

    context "when the realm table is empty" do
      it "should fetch realms from blizzard and put them in the database" do
        stub = stub_request(:get, /us.api.battle.net\/wow\/realm\/status/).
               to_return(body: realm_statuses, status: 200)
        Realm.destroy_all
        Realm.refresh
        expect(stub).to have_been_requested.once
        expect(Realm.count).to eq(2)
      end
    end

    context "when realm table data is stale" do
      before do
        realm = Realm.create!(name: "testing")
        realm.updated_at = 1.week.ago
        realm.save
      end

      it "should replace the realm table contents with data from blizzard" do
        stub = stub_request(:get, /us.api.battle.net\/wow\/realm\/status/).
               to_return(body: realm_statuses, status: 200)
        Realm.refresh
        expect(stub).to have_been_requested.once
        expect(Realm.count).to eq(2)
      end
    end

    context "when realm table data is less than a day old" do
      before { Realm.create!(name: "testing") }
      after { Realm.destroy(Realm.find_by_name("testing").id) }
      
      it "should not fetch realm data from blizzard" do
        stub = stub_request(:get, /us.api.battle.net\/wow\/realm\/status/)
                Realm.refresh
        expect(stub).not_to have_been_requested
      end
    end

    context "when the get request is not successful" do
      it "should not modify the database" do
        stub = stub_request(:get, /us.api.battle.net\/wow\/realm\/status/).
               to_return(body: realm_statuses, status: 500)
        Realm.refresh
        expect(stub).to have_been_requested.once
        expect(Realm.count).to eq(0)
      end
    end
  end
end
