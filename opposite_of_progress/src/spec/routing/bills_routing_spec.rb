require "rails_helper"

RSpec.describe BillsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/bills").to route_to("bills#index")
    end

    it "routes to #new" do
      expect(:get => "/bills/new").to route_to("bills#new")
    end

    it "routes to #show" do
      expect(:get => "/bills/1").to route_to("bills#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/bills/1/edit").to route_to("bills#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/bills").to route_to("bills#create")
    end

    it "routes to #update" do
      expect(:put => "/bills/1").to route_to("bills#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/bills/1").to route_to("bills#destroy", :id => "1")
    end

  end
end
