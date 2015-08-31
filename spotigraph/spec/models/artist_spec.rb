require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe '.find_artist' do
    let(:valid_names) { ['Black Sabbath', 'Radiohead'] }

    # Note, Faker will not generate names of this form
    let(:invalid_names) do
      %w(sPUKslXlnz pdbPxLK7rt w8yUJnC171 mLvr4IaeC8 ZYR9Z5R967)
    end

    let(:random_array_size_max) { 20 }

    it 'returns nil if we search against an empty array' do
      valid_names.each do |name|
        expect(Artist.find_matching_name([], name)).to eq(nil)
      end
    end

    it 'finds an artist when present in a single artist array' do
      valid_names.each do |name|
        artist = build(:artist, name: name)
        artist_array = generate_artist_array(1, artist: artist)
        expect(Artist.find_matching_name(artist_array, name)).to eq(artist)
      end
    end

    it 'finds an artist when present independent of case' do
      name = 'BlAcK SAbbAth'
      artist = build(:artist, name: 'blACk SaBBath')
      artist_array = generate_artist_array(1, artist: artist)
      expect(Artist.find_matching_name(artist_array, name)).to eq(artist)
    end

    it 'returns nil when the artist is not present in the array' do
      artist_array = generate_artist_array(1)
      invalid_names.each do |invalid|
        expect(Artist.find_matching_name(artist_array, invalid)).to eq(nil)
      end
    end

    it 'finds an artist present in a randomly sized array' do
      valid_names.each do |name|
        size = rand(2...random_array_size_max)
        artist = build(:artist, name: name)
        artist_array = generate_artist_array(size, artist: artist)
        expect(Artist.find_matching_name(artist_array, name)).to eq(artist)
      end
    end

    it 'fails to find an artist not present in a randomly sized array' do
      size = rand(2...random_array_size_max)
      artist_array = generate_artist_array(size)
      invalid_names.each do |invalid|
        expect(Artist.find_matching_name(artist_array, invalid)).to eq(nil)
      end
    end

    def generate_artist_array(size, options = {})
      artist_array = []
      unless options[:artist].nil?
        artist_array << options[:artist]
        size -= 1
      end
      size.times do
        artist_array << build(:artist, name: Faker::Name.name)
      end
      artist_array
    end
  end

  describe '.collect_related_artists' do
    let(:max_size) { 5 }

    it 'correctly merges an array of names' do
      max_size.times do |size|
        names = generate_name_array(size)
        artists = generate_artist_array(names)
        error = "failed on depth #{size}"
        expect(Artist.collect_related_artists(artists)).to eq(names), error
      end
    end
    def generate_name_array(size)
      name_array = []
      size.times do
        name_array << Faker::Name.name
      end
      name_array
    end

    def generate_artist_array(names)
      artist_array = []
      names.each do |name|
        artist_array << build(:artist, name: name)
      end
      artist_array
    end
  end

  describe '.search_spotify' do
    let(:not_on_spotify) do
      %w(sPUKslXlnz pdbPxLK7rt w8yUJnC171 mLvr4IaeC8 ZYR9Z5R967)
    end

    it 'finds an graph given the artist is on spotify' do
      artist = Artist.search_spotify('Black Sabbath')
      expect(artist.name).to eq('Black Sabbath')
    end

    it 'returns nil if the artist is not on spotify' do
      not_on_spotify.each do |invalid|
        artist = Artist.search_spotify(invalid)
        expect(artist).to be nil
      end
    end
  end

  describe '.cache_artist' do
    let(:valid_artists) { %w(Radiohead Mixtapes) }
    let(:not_on_spotify) do
      %w(sPUKslXlnz pdbPxLK7rt w8yUJnC171 mLvr4IaeC8 ZYR9Z5R967)
    end

    it 'caches artists that are on spotify' do
      valid_artists.each do |name|
        expect(Artist.find_by(name: name)).to be(nil), 'Artist should not start in the db'
        artist = Artist.search_spotify(name)
        expect(Artist.cache_artist(artist)).to_not be(nil)
      end
    end

    it 'does not cache artists that it does not find on spotify' do
      not_on_spotify.each do |name|
        expect(Artist.find_by(name: name)).to be(nil), 'Artist should not start in the db'
        artist = Artist.search_spotify(name)
        expect(Artist.cache_artist(artist)).to be(nil)
      end
    end
  end
end
