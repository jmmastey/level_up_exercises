require 'rails_helper'

RSpec.describe "ActivitiesController", type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/activities/1").to route_to("activities#show", id: "1")
    end

    it "routes to #add_to_goals" do
      expect(patch: "/activities/add_to_goals/1")
        .to route_to("activities#add_to_goals", id: "1")
    end

    it "routes to #remove_from_goals" do
      expect(patch: "/activities/remove_from_goals/1")
        .to route_to("activities#remove_from_goals", id: "1")
    end

    it "routes to #hide" do
      expect(patch: "/activities/hide/1")
        .to route_to("activities#hide", id: "1")
    end

      it "routes to #unhide" do
      expect(patch: "/activities/unhide")
        .to route_to("activities#unhide")
    end
end
end
