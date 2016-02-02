require "rails_helper"

describe FavoritesController do
  before(:each) do
    request.env["HTTP_REFERER"] = "http://test.host/foo"
  end

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
        menu_item = FactoryGirl.create(
          :menu_item
        )

        sign_in(user)
        get(:new, id: menu_item.id)
        fave = Favorite.find_by(user: user)

        expect(fave.menu_item).to eq(menu_item)
      end
    end

    context "When not logged in and adding a legit item to favorites" do
      it "does not save the favorited item" do
        menu_item = FactoryGirl.create(
          :menu_item
        )

        get(:new, id: menu_item.id)

        expect(Favorite.count).to eq(0)
      end
    end

    it "redirects to :back" do
      get :new
      expect(response).to redirect_to(:back)
    end
  end

  describe "#destroy" do
    context "When logged in and deleting legit item from favorites" do
      it "removes the favorited item" do
        fave = FactoryGirl.create(:favorite)
        sign_in(fave.user)
        get(:destroy, id: fave.id)
        favorites = Favorite.where(user_id: fave.user.id)

        expect(favorites.length).to eq(0)
      end
    end

    context "When not logged in and deleting a legit item from favorites" do
      it "does not remove the favorited item" do
        fave = FactoryGirl.create(:favorite)
        get(:destroy, id: fave.id)
        expect(Favorite.find(fave.id)).to eq(fave)
      end
    end

    it "redirects to :back" do
      get :destroy
      expect(response).to redirect_to(:back)
    end
  end
end
