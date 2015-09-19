require "rails_helper"

RSpec.describe CharactersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/characters").to route_to("characters#index")
    end

    it "routes to #show" do
      expect(get: "/characters/1").to route_to("characters#show", id: "1")
    end
  end
end
