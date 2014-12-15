require 'rails_helper'

RSpec.describe ArtistParser do
  let(:json_data_for_artist)  { File.read("spec/support/data_files/warhol.json") }

  describe ".parse" do
    it "will parse the json data and return a hash of parameters" do
      artist_params = ArtistParser.parse(json_data_for_artist)

      expect(artist_params["id"]).to eq("4d8b92b34eb68a1b2c0003f4")
    end
  end
end
