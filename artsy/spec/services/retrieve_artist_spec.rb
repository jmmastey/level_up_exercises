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
end
