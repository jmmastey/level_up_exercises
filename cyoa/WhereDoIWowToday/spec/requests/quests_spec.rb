require 'rails_helper'

RSpec.describe "Quests", type: :request do
  describe "GET /quests" do
    it "works! (now write some real specs)" do
      get quests_path
      expect(response).to have_http_status(200)
    end
  end
end
