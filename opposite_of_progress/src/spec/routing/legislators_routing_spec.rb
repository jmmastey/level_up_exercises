require "rails_helper"

RSpec.describe LegislatorsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/legislators").to route_to("legislators#index")
    end

    it "routes to #new" do
      expect(:get => "/legislators/new").to route_to("legislators#new")
    end

    it "routes to #show" do
      expect(:get => "/legislators/1").to route_to("legislators#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/legislators/1/edit").to route_to("legislators#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/legislators").to route_to("legislators#create")
    end

    it "routes to #update" do
      expect(:put => "/legislators/1").to route_to("legislators#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/legislators/1").to route_to("legislators#destroy", :id => "1")
    end

  end
end
