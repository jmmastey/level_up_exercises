require 'rails_helper'

RSpec.describe FavoritesController, :type => :controller do

  describe "POST #create" do
    let(:artist) { create(:artist) }
    let(:user_session) { nil }

    context "when not logged in" do

      it "cannot favorite an artist" do
        post :create, artist_id: artist

        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:artist) { create(:artist) }
    let(:favorite_id) { 1 }

    context "when not logged in" do

      it "cannot unfavorite an artist" do
        delete :destroy, artist_id: artist, id: favorite_id

        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
end
