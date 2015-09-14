require "rails_helper"

RSpec.describe AchievementsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/achievements").to route_to("achievements#index")
    end

    it "routes to #new" do
      expect(get: "/achievements/new").to route_to("achievements#new")
    end

    it "routes to #show" do
      expect(get: "/achievements/1").to route_to("achievements#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/achievements/1/edit")
        .to route_to("achievements#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/achievements").to route_to("achievements#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/achievements/1").to route_to("achievements#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/achievements/1")
        .to route_to("achievements#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/achievements/1")
        .to route_to("achievements#destroy", id: "1")
    end
  end
end
