require "rails_helper"

RSpec.describe CharactersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/characters").to route_to("characters#index")
    end

    it "routes to #new" do
      expect(:get => "/characters/new").to route_to("characters#new")
    end

    it "routes to #show" do
      expect(:get => "/characters/1").to route_to("characters#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/characters/1/edit").to route_to("characters#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/characters").to route_to("characters#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/characters/1").to route_to("characters#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/characters/1").to route_to("characters#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/characters/1").to route_to("characters#destroy", :id => "1")
    end

  end
end
