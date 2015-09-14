require "rails_helper"

RSpec.describe RealmsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/realms").to route_to("realms#index")
    end

    it "routes to #new" do
      expect(get: "/realms/new").to route_to("realms#new")
    end

    it "routes to #show" do
      expect(get: "/realms/1").to route_to("realms#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/realms/1/edit").to route_to("realms#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/realms").to route_to("realms#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/realms/1").to route_to("realms#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/realms/1").to route_to("realms#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/realms/1").to route_to("realms#destroy", id: "1")
    end
  end
end
