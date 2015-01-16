require 'rails_helper'

RSpec.describe UserController, :type => :controller do

  describe "GET favorite" do
    it "returns http success" do
      get :favorite
      expect(response).to have_http_status(:success)
    end
  end

end
