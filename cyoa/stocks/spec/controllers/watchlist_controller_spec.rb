require 'rails_helper'

RSpec.describe WatchlistController do
  context "User signed in" do
    login_user
    let(:user) { User.first }

    describe "GET index" do
      it "assigns @stocks" do
        get :index
        expect(assigns(:stocks)).not_to be_empty
      end

      it "renders the index page" do
        get :index
        expect(response).to render_template("index")
      end
    end

    describe "POST update" do
      it "adds the stock to the watchlist if it is not already there" do
        current_stock_count = user.stocks.count
        new_stock = FactoryGirl.create(:stock, symbol: "TEST")
        post :update, id: new_stock.symbol.to_s, format: :json
        expect(user.stocks.count).to eq(current_stock_count + 1)
      end

      it "removes the stock from the watchlist if it is already there" do
        current_stock_count = user.stocks.count
        post :update, id: user.stocks.first.symbol, format: :json
        expect(user.stocks.count).to eq(current_stock_count - 1)
      end

      it "raises error if stock symbol doesnt exist" do
        expect { post :update, id: "FAKE", format: :json }.to raise_error(ArgumentError)
      end
    end
  end

  context "User not signed in" do
    describe "GET index" do
      it "raises an error if no user is logged in" do
        expect { get :index }.to raise_error
      end
    end

    describe "POST update" do
      it "raises an error if no user is logged in" do
        expect { post :update, id: "FAKE", format: :json }.to raise_error
      end
    end

    describe "GET feed" do
      before(:each) do
        FactoryGirl.create(:user, :with_stocks)
      end

      it "raises an error if the user id does not exist" do
        expect { get :feed, id: User.last.id + 1, format: :atom }.to raise_error
      end

      it "renders the atom feed" do
        get :feed, id: User.last.id, format: :atom
        expect(response).to have_http_status(200)
      end

      it "sets title, watched stocks and updated fields for feed" do
        get :feed, id: User.last.id, format: :atom
        expect(assigns(:title)).not_to be_nil
        expect(assigns(:watched_stocks)).not_to be_empty
        expect(assigns(:updated)).not_to be_nil
      end
    end
  end
end