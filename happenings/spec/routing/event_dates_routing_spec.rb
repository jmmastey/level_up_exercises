require "rails_helper"

RSpec.describe EventDatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/event_dates").to route_to("event_dates#index")
    end

    it "routes to #new" do
      expect(get: "/event_dates/new").to route_to("event_dates#new")
    end

    it "routes to #show" do
      expect(get: "/event_dates/1").to route_to("event_dates#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/event_dates/1/edit").to route_to("event_dates#edit",
        id: "1")
    end

    it "routes to #create" do
      expect(post: "/event_dates").to route_to("event_dates#create")
    end

    it "routes to #update" do
      expect(put: "/event_dates/1").to route_to("event_dates#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/event_dates/1").to route_to("event_dates#destroy",
        id: "1")
    end

  end
end
