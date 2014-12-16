require "rails_helper"
require 'support/data_files/sample_api_data'

describe RetrieveArtist do
  let(:name) { "andy-warhol"}
  let(:artist_hash)  { SampleData::RESPONSE }

  describe "#get_artist data" do
    it "obtains the artist hash from the artsy api wrapper" do
      artist_retriever = double("retrieve_artist")

      expect(artist_retriever).to receive(:get_artist_data).with(:name)

      artist_retriever.get_artist_data('andy-warhol')
    end
  end

  describe "new_record?" do
    it "returns false if there is an existing record for the artist" do
      # existing_artist = create(:retrieve_artist)
      # new_artist = create(:retrieve_artist)

      # expect(new_artist.new_record?).to be false
    end

    it "returns true if there is no existing record for the artist" do
      # artist = create(:artist, first_name: "Andy", last_name: "Warhol", api_id: "1234")

      # expect(artist.new_record?).to be true
    end
  end

  context "new artist" do

  end
end
