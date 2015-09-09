require 'rails_helper'

RSpec.describe "Achievements", type: :request do
  describe "GET /achievements" do
    it "works! (now write some real specs)" do
      get achievements_path
      expect(response).to have_http_status(200)
    end
  end
end
