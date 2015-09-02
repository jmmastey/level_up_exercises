require 'rails_helper'

RSpec.describe Artist, type: :model do
  let(:valid_artists)   { TestData.valid_artists }
  let(:invalid_artists) { TestData.invalid_artists }
  let(:not_seeded_artists) { TestData.not_seeded_artists }
  let(:random_array_size_max) { 20 }

  describe '.find_artist' do
    it 'returns nil if we search against an empty array' do
      valid_artists.each do |name|
        expect(Artist.find_matching_name([], name)).to be_nil
      end
    end

    it 'finds an artist when present in a single artist array' do
      valid_artists.each do |name|
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
      invalid_artists.each do |invalid|
        expect(Artist.find_matching_name(artist_array, invalid)).to be_nil
      end
    end

    it 'finds an artist present in a randomly sized array' do
      valid_artists.each do |name|
        size = rand(2...random_array_size_max)
        artist = build(:artist, name: name)
        artist_array = generate_artist_array(size, artist: artist)
        expect(Artist.find_matching_name(artist_array, name)).to eq(artist)
      end
    end

    it 'fails to find an artist not present in a randomly sized array' do
      size = rand(2...random_array_size_max)
      artist_array = generate_artist_array(size)
      invalid_artists.each do |invalid|
        expect(Artist.find_matching_name(artist_array, invalid)).to be_nil
      end
    end
  end

  describe '.collect_related_artists' do
    it 'correctly merges an array of names' do
      random_array_size_max.times do |size|
        names = generate_name_array(size)
        artists = generate_artist_array_from_names(names)
        error = "failed on depth #{size}"
        expect(Artist.collect_related_artists(artists)).to eq(names), error
      end
    end
  end

  describe '.search_spotify' do
    it 'finds an artist given the artist is on spotify' do
      artist = Artist.search_spotify('Black Sabbath')
      expect(artist.name).to eq('Black Sabbath')
    end

    it 'returns nil if the artist is not on spotify' do
      invalid_artists.each do |invalid|
        artist = Artist.search_spotify(invalid)
        expect(artist).to be(nil), "Failed for #{invalid}"
      end
    end
  end

  describe '.cache_artist' do
    it 'caches artists that are on spotify' do
      not_seeded_artists.each do |name|
        expect(Artist.find_by(name: name)).to be(nil), 'Artist should not start in the db'
        artist = Artist.search_spotify(name)
        expect(Artist.cache_artist(artist)).to_not be(nil)
      end
    end

    it 'does not cache artists that it does not find on spotify' do
      invalid_artists.each do |name|
        expect(Artist.find_by(name: name)).to be(nil), 'Artist should not start in the db'
        artist = Artist.search_spotify(name)
        expect(Artist.cache_artist(artist)).to be(nil)
      end
    end
  end

  def generate_name_array(size)
    name_array = []
    size.times do
      name_array << Faker::Name.name
    end
    name_array
  end

  def generate_artist_array_from_names(names)
    artist_array = []
    names.each do |name|
      artist_array << build(:artist, name: name)
    end
    artist_array
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
