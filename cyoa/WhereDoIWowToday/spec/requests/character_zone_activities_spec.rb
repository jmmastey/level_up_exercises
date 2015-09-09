require 'rails_helper'

RSpec.describe "CharacterZoneActivities", type: :request do
  describe "GET /character_zone_activities" do
    it "works! (now write some real specs)" do
      get character_zone_activities_path
      expect(response).to have_http_status(200)
    end
  end
end
