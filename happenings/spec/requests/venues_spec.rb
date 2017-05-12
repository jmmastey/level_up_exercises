require 'rails_helper'

RSpec.describe "Venues", type: :request do
  describe "GET /venues" do
    it "works! (now write some real specs)" do
      get venues_path
      expect(response).to have_http_status(200)
    end
  end
end
