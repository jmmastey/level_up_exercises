require 'rails_helper'
require Rails.root.join("spec/support/support_methods.rb")

RSpec.describe SearchForController, :type => :controller do

  describe "#convert_artist_name_for_search" do
    let(:search_query) { "Andy Warhol" }

    it "changes the artist search query for the API" do
      artist_name = SearchForController.convert_artist_name_for_search(search_query)

      expect(artist_name).to eq("andy-warhol")
    end
  end

  describe "GET #artist" do

    it "should restrict access for non-admin users" do
      create_and_sign_in_user

      get :artist, search_query: "Pablo Picasso"

      expect(response).to redirect_to(root_url)
    end
  end
end
