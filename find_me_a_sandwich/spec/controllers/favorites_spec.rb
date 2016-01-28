require "rails_helper"

describe FavoritesController do
  describe "#show" do
    context "When not logged in" do
      it "renders the show template" do
        get :show
        expect(response).to render_template("show")
      end
    end

    it "assigns @favorites" do
      get :show
      expect(assigns(:favorites)).to eq([])
    end
  end

  describe "#new" do
    it "redirects to :back" do
      request.env["HTTP_REFERER"] = "http://test.host/foo"
      get :new
      expect(response).to redirect_to(:back)
    end
  end

  describe "#destroy" do
    it "redirects to :back" do
      request.env["HTTP_REFERER"] = "http://test.host/foo"
      get :destroy
      expect(response).to redirect_to(:back)
    end
  end
end
