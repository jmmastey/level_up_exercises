require "rails_helper"

RSpec.describe CalendarEventsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/calendar_events").to route_to("calendar_events#index")
    end

    it "routes to #new" do
      expect(:get => "/calendar_events/new").to route_to("calendar_events#new")
    end

    it "routes to #show" do
      expect(:get => "/calendar_events/1").to route_to("calendar_events#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/calendar_events/1/edit").to route_to("calendar_events#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/calendar_events").to route_to("calendar_events#create")
    end

    it "routes to #update" do
      expect(:put => "/calendar_events/1").to route_to("calendar_events#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/calendar_events/1").to route_to("calendar_events#destroy", :id => "1")
    end

  end
end
