require 'rails_helper'

RSpec.describe Artist, :type => :model do

  describe '#full_name' do
    let(:artist) { FactoryGirl.create(:artist, first_name: "Claude", last_name: "Monet") }

    it 'returns the full name of the artist' do

      expect(artist.full_name).to eq("Claude Monet")
    end
  end

  describe "set_thumbnail" do
    let(:artist) { create(:artist, first_name: "Andy",  last_name: "Warhol") }
    let(:fake_artsy_wrapper) { instance_double(ArtsyApiWrapper) }

    it "can retrieve the url for the artist's image thumbnail" do
      allow(fake_artsy_wrapper).to receive(:artist_url).and_return("warhol_url.jpg")
      allow(ArtsyApiWrapper).to receive(:new).and_return(fake_artsy_wrapper)
      artist.set_thumbnail
      expect(fake_artsy_wrapper).to have_received(:artist_url)
      expect(ArtsyApiWrapper).to have_received(:new)
    end
  end
end
