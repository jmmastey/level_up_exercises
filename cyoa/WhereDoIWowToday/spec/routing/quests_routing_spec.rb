require "rails_helper"

RSpec.describe QuestsController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/quests/1").to route_to("quests#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/quests/1/edit").to route_to("quests#edit", id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/quests/1").to route_to("quests#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/quests/1").to route_to("quests#update", id: "1")
    end
  end
end
