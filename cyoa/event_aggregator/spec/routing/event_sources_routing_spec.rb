require "rails_helper"

RSpec.describe EventSourcesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/event_sources").to route_to("event_sources#index")
    end

    it "routes to #new" do
      expect(:get => "/event_sources/new").to route_to("event_sources#new")
    end

    it "routes to #show" do
      expect(:get => "/event_sources/1").to route_to("event_sources#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/event_sources/1/edit").to route_to("event_sources#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/event_sources").to route_to("event_sources#create")
    end

    it "routes to #update" do
      expect(:put => "/event_sources/1").to route_to("event_sources#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/event_sources/1").to route_to("event_sources#destroy", :id => "1")
    end

  end
end
