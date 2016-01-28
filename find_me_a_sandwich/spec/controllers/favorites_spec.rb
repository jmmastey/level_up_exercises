require "rails_helper"

describe FavoritesController do
  describe "#show" do
    context "When not logged in" do
      it "renders the show template" do
        get :show
        expect(response).to render_template("show")
      end
    end
  end
end
