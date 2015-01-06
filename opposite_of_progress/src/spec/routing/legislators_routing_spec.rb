require "rails_helper"

RSpec.describe LegislatorsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/legislators").to route_to("legislators#index")
    end

    it "routes to #show" do
      expect(:get => "/legislators/1").to route_to("legislators#show", :id => "1")
    end

  end
end
