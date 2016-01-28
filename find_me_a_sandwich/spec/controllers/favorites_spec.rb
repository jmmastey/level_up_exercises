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
    context "When logged in and adding a legit item to favorites" do
      it "saves the item as a favorite" do
        user = FactoryGirl.create(:user, password: "1234asdf")
        merchant = FactoryGirl.create(:merchant, name: "FOO")
        menu = FactoryGirl.create(:menu, name: "foobar", merchant_id: merchant.id)
        menu_item = FactoryGirl.create(
          :menu_item, name: "barbaz", menu_id: menu.id, menu_group: "foogroup"
        )
        request.env["HTTP_REFERER"] = "http://test.host/foo"

        sign_in(user)
        get(:new, id: menu_item.id)
        fave = Favorite.find_by(user: user)

        expect(fave.menu_item).to eq(menu_item)
      end
    end

    it "redirects to :back" do
      request.env["HTTP_REFERER"] = "http://test.host/foo"
      get :new
      expect(response).to redirect_to(:back)
    end
  end

  describe "#destroy" do
    context "When logged in and deleting legit item from favorites" do
      it "removes the favorited item" do
        user = FactoryGirl.create(:user, password: "1234asdf")
        merchant = FactoryGirl.create(:merchant, name: "FOO")
        menu = FactoryGirl.create(:menu, name: "foobar", merchant_id: merchant.id)
        menu_item = FactoryGirl.create(
          :menu_item, name: "barbaz", menu_id: menu.id, menu_group: "foogroup"
        )
        fave = Favorite.create(menu_item: menu_item, user: user)

        request.env["HTTP_REFERER"] = "http://test.host/foo"

        sign_in(user)
        get(:destroy, id: fave.id)

        favorites = Favorite.where(user_id: user.id)

        expect(favorites.length).to eq(0)
      end
    end

    it "redirects to :back" do
      request.env["HTTP_REFERER"] = "http://test.host/foo"
      get :destroy
      expect(response).to redirect_to(:back)
    end
  end
end
