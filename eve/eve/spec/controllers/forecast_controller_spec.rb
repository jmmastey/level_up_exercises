require 'rails_helper'

RSpec.describe ForecastController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET recent" do
    it "returns http success" do
      get :recent
      expect(response).to be_success
    end
  end

  describe "GET search" do
    it "returns http success" do
      get :search
      expect(response).to be_success
    end
  end

end
