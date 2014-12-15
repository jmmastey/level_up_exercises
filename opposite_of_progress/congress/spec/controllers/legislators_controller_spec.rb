require 'spec_helper'

describe LegislatorsController, type: :controller do
  before :each do
    bioguide_id = Faker::Lorem.characters(7)
    @bill = FactoryGirl.create(:bill, sponsor_id: bioguide_id)
    @legislator = FactoryGirl.create(:legislator, bioguide_id: bioguide_id)
  end

  describe "GET #index" do
    before :each do
      get :index, sort_by: "created_at DESC"
    end

    it "renders the :index view" do
      assert_equal 200, response.status
    end

    it "populates an array of legislators with pagination" do
      expect(assigns(:results)).to include(@legislator)
    end
  end

  describe "GET #show" do
    before :each do
      get :show, id: @legislator
    end

    it "renders the :show view" do
      assert_equal 200, response.status
    end

    it "assigns the related bill to @related_bills" do
      expect(assigns(:related_bills)).to include(@bill)
    end
  end
end
