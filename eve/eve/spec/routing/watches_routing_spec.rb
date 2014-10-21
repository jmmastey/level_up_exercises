require "rails_helper"

RSpec.describe WatchesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/watches").to route_to("watches#index")
    end

    it "routes to #new" do
      expect(:get => "/watches/new").to route_to("watches#new")
    end

    it "routes to #show" do
      expect(:get => "/watches/1").to route_to("watches#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/watches/1/edit").to route_to("watches#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/watches").to route_to("watches#create")
    end

    it "routes to #update" do
      expect(:put => "/watches/1").to route_to("watches#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/watches/1").to route_to("watches#destroy", :id => "1")
    end

  end
end
