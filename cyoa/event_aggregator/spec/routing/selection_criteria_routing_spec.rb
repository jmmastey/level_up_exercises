require "rails_helper"

RSpec.describe SelectionCriteriaController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/selection_criteria").to route_to("selection_criteria#index")
    end

    it "routes to #new" do
      expect(:get => "/selection_criteria/new").to route_to("selection_criteria#new")
    end

    it "routes to #show" do
      expect(:get => "/selection_criteria/1").to route_to("selection_criteria#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/selection_criteria/1/edit").to route_to("selection_criteria#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/selection_criteria").to route_to("selection_criteria#create")
    end

    it "routes to #update" do
      expect(:put => "/selection_criteria/1").to route_to("selection_criteria#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/selection_criteria/1").to route_to("selection_criteria#destroy", :id => "1")
    end

  end
end
