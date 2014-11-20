require 'spec_helper'

describe "Legislators API", :type => :request do
  before :all do
    @legislator = FactoryGirl.create(:legislator)
  end

  describe "has a functional legislator detail page" do
    before :all do
      get "/legislators/#{@legislator.id}.json"
    end

    it "retrieves the legislator detail page" do
      expect(response).to be_success
    end

    it "retrieves data of a specific legislator" do
      expect(response.body).to include(@legislator.bioguide_id)
    end
  end

  describe "has a functional legislator list page" do
    before :all do
      get "/legislators.json"
    end

    it "retrieves the legislator list page" do
      expect(response).to be_success
    end

    it "retrieves data of a legislator from a list page" do
      expect(response.body).to include(@legislator.bioguide_id)
    end
  end
end