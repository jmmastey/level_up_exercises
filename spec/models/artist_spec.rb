require 'rails_helper'

RSpec.describe Artist, :type => :model do

  # Validations
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  # Associations
  it { should have_many(:artworks) }

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

  describe ".most_recent" do


    it "orders the artists by updated_date" do
      artist_1 = create(:artist, first_name: "Artist",  last_name: "One", updated_at: 1.day.ago)
      artist_2 = create(:artist, first_name: "Artist",  last_name: "Two", updated_at: 3.days.ago)
      artist_3 = create(:artist, first_name: "Artist",  last_name: "Three", updated_at: 2.days.ago)

      artists = Artist.most_recent

      expect(artists.first).to eq(artist_1)
      expect(artists.last).to eq(artist_2)
    end
  end
end
