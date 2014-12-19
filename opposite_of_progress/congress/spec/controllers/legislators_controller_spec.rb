require 'spec_helper'

describe LegislatorsController, type: :controller do
  let(:bioguide_id) { Faker::Lorem.characters(7) }
  let(:bill) { FactoryGirl.create(:bill, sponsor_id: bioguide_id) }
  let(:legislator) { FactoryGirl.create(:legislator, bioguide_id: bioguide_id) }

  describe "GET #index" do
    before :each do
      get :index, sort_by: "created_at DESC"
    end

    it "renders the :index view" do
      expect(response.status).to eq(200)
    end

    it "populates an array of legislators with pagination" do
      expect(assigns(:results)).to include(legislator)
    end
  end

  describe "GET #show" do
    before :each do
      get :show, id: legislator
    end

    it "renders the :show view" do
      expect(response.status).to eq(200)
    end

    it "assigns the related bill to @related_bills" do
      expect(assigns(:related_bills)).to include(bill)
    end
  end
end
