require 'rails_helper'

RSpec.describe Realm, type: :model do
  describe ".refresh" do
    let(:realm_statuses) { IO.read("spec/test_data/realm_status_body.txt") }

    context "when the realm table is empty" do
      it "should fetch realms from blizzard and put them in the database" do
        stub = stub_realm_status_api(realm_statuses)
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
        stub = stub_realm_status_api(realm_statuses)

        Realm.refresh

        expect(stub).to have_been_requested.once
        expect(Realm.count).to eq(2)
      end
    end

    context "when realm table data is less than a day old" do
      before { Realm.create!(name: "testing") }
      after { Realm.destroy(Realm.find_by_name("testing").id) }
      
      it "should not fetch realm data from blizzard" do
        stub = stub_realm_status_api(realm_statuses)

        Realm.refresh

        expect(stub).not_to have_been_requested
      end
    end

    context "when the get request is not successful" do
      it "should not modify the database" do
        stub = stub_realm_status_api(realm_statuses, response_status: 500)

        Realm.refresh

        expect(stub).to have_been_requested.once
        expect(Realm.count).to eq(0)
      end

      it "should not return an error message" do
        stub = stub_realm_status_api(realm_statuses, response_status: 500)

        message = Realm.refresh

        expect(stub).to have_been_requested.once
        expect(message).to include("unavailable")
      end
    end
  end
end

def stub_realm_status_api(body, response_status: 200)
  stub_request(:any, /realm\/status/)
    .to_return(body: body, status: response_status)
end
