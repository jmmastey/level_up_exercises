require "rails_helper"

RSpec.describe GoodDeedsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/good_deeds").to route_to("good_deeds#index")
    end

    it "routes to #new" do
      expect(:get => "/good_deeds/new").to route_to("good_deeds#new")
    end

    it "routes to #show" do
      expect(:get => "/good_deeds/1").to route_to("good_deeds#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/good_deeds/1/edit").to route_to("good_deeds#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/good_deeds").to route_to("good_deeds#create")
    end

    it "routes to #update" do
      expect(:put => "/good_deeds/1").to route_to("good_deeds#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/good_deeds/1").to route_to("good_deeds#destroy", :id => "1")
    end

  end
end
