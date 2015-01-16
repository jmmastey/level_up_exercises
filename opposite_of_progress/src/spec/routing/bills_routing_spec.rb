require "rails_helper"

RSpec.describe BillsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/bills").to route_to("bills#index")
    end

    it "routes to #show" do
      expect(:get => "/bills/1").to route_to("bills#show", :id => "1")
    end

    it "routes to #favorites" do
      expect(:get => "/bills/favorites").to route_to("bills#favorites")
    end
  end
end
