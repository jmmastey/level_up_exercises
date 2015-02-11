require 'rails_helper'

RSpec.describe HomeController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  it "returns the default lat lon in the right format" do
    expect(HomeController.default_lat_lon).to match(/[\-]?\d{1,2}\.\d+,[\-]?\d{1,3}\.\d+( [\-]?\d{1,2}\.\d+,[\-]?\d{1,3}\.\d+)*/)
  end
end
