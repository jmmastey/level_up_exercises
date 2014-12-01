require 'spec_helper'

describe "Bills API", type: :request do
  before :all do
    @bill = FactoryGirl.create(:bill)
  end

  describe "has a functional bill detail page" do
    before :all do
      get "/bills/#{@bill.id}.json"
    end

    it "retrieves the bill detail page" do
      expect(response).to be_success
    end

    it "retrieves data of a specific bill" do
      expect(response.body).to include(@bill.bill_id)
    end
  end

  describe "has a functional bill list page" do
    before :all do
      get "/bills.json"
    end

    it "retrieves the bill list page" do
      expect(response).to be_success
    end

    it "retrieves data of a bill from a list page" do
      expect(response.body).to include(@bill.bill_id)
    end
  end
end
