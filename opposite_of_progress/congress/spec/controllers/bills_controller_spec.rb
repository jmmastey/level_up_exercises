require 'spec_helper'

describe BillsController, type: :controller do
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

    it "populates an array of bills with pagination" do
      expect(assigns(:results)).to include(@bill)
    end
  end

  describe "GET #show" do
    before :each do
      get :show, id: @bill
    end

    it "renders the :show view" do
      assert_equal 200, response.status
    end

    it "assigns the related legislator to @legislator" do
      expect(assigns(:legislator)).to eq(@legislator)
    end
  end
end
