require "rails_helper"

RSpec.describe GoodDeedsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/good_deeds").to route_to("good_deeds#index")
    end

  end
end
