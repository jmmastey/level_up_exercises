require "rails_helper"

RSpec.describe VenuesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/venues").to route_to("venues#index")
    end

    it "routes to #new" do
      expect(:get => "/venues/new").to route_to("venues#new")
    end

    it "routes to #show" do
      expect(:get => "/venues/1").to route_to("venues#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/venues/1/edit").to route_to("venues#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/venues").to route_to("venues#create")
    end

    it "routes to #update" do
      expect(:put => "/venues/1").to route_to("venues#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/venues/1").to route_to("venues#destroy", :id => "1")
    end

  end
end
