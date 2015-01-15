require "rails_helper"

RSpec.describe LegislatorsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/legislators").to route_to("legislators#index")
    end

    it "routes to #show" do
      expect(:get => "/legislators/1").to route_to("legislators#show", id: "1")
    end

    it "routes to #search" do
      expect(:get => "/legislators/illinois").to route_to("legislators#search", state: "illinois")
    end

    it "routes to #favorites" do
      expect(:get => "/legislators/favorites").to route_to("legislators#favorites")
    end

    it "routes to #seach_by_location" do
      expect(:get => "/search?search=60056").to route_to("legislators#search_by_location", search: "60056" )
    end
  end
end
