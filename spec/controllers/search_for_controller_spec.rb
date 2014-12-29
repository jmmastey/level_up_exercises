require 'rails_helper'

RSpec.describe SearchForController, :type => :controller do

  describe "#convert_artist_name_for_search" do
    let(:search_query) { "Andy Warhol" }

    it "changes the artist search query for the API" do
      artist_name = SearchForController.convert_artist_name_for_search(search_query)

      expect(artist_name).to eq("andy-warhol")
    end
  end
end
