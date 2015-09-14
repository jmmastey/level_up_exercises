require "rails_helper"

RSpec.describe CharacterZoneActivitiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/character_zone_activities")
        .to route_to("character_zone_activities#index")
    end

    it "routes to #new" do
      expect(get: "/character_zone_activities/new")
        .to route_to("character_zone_activities#new")
    end

    it "routes to #show" do
      expect(get: "/character_zone_activities/1")
        .to route_to("character_zone_activities#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/character_zone_activities/1/edit")
        .to route_to("character_zone_activities#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/character_zone_activities")
        .to route_to("character_zone_activities#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/character_zone_activities/1")
        .to route_to("character_zone_activities#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/character_zone_activities/1")
        .to route_to("character_zone_activities#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/character_zone_activities/1")
        .to route_to("character_zone_activities#destroy", id: "1")
    end
  end
end
