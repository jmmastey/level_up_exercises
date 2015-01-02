require 'rails_helper'

RSpec.describe Artist, :type => :model do

  describe "Create new artist" do

    it "validates a new valid artist" do
      artist = Artist.new
      artist.first_name = "Pablo"
      artist.last_name = "Picasso"

      expect(artist).to be_valid
    end

    it "does not validate a new invalid artist" do
      artist = Artist.new
      artist.first_name = "Pablo"
      artist.last_name = ""

      artist.valid?

      expect(artist).not_to be_valid
    end
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe "associations" do
    it { should have_many(:artworks) }
    it { should have_many(:favorites) }
    it { should have_many(:followers) }
  end

  describe "dependent destroy" do
    let(:artist) { create(Artist.new(first_name: "Pablo", last_name: "Picasso")) }
    let(:artwork) { artist.artworks.create(title: "Artwork", date: 1.day.ago) }

    it "destroys dependent artworks when an artist is destroyed" do
      artist = Artist.create(first_name: "Pablo", last_name: "Picasso")
      artwork = artist.artworks.create(title: "Artwork", date: 1.day.ago)

      expect(Artwork.all.size).to eq(1)

      artist.destroy

      expect(Artwork.all.size).to eq(0)
    end
  end

  describe '#full_name' do
    let(:artist) { FactoryGirl.create(:artist, first_name: "Claude", last_name: "Monet") }

    it 'returns the full name of the artist' do

      expect(artist.full_name).to eq("Claude Monet")
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
