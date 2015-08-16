require 'rails_helper'

RSpec.describe Artist, type: :model do
  # merge
  describe 'Artist.depth_merge!' do
    it 'two empty' do
      quick_merge_expectation({},{},{})
    end

    it 'right empty' do
      quick_merge_expectation({'first' => 1},{},{'first' => 1})
    end

    it 'left empty' do
      quick_merge_expectation({},{'first' => 1},{'first' => 1})
    end

    it 'none empty, none coincide' do
      quick_merge_expectation({'first' => 1},{'second' => 2},{'first' => 1, 'second' => 2})
    end

    it 'none empty, one coincides (eq val)' do
      quick_merge_expectation({'1' => 1}, {'1' => 1}, {'1' => 1})
    end

    it 'none empty, one coincides (min left val)' do
      quick_merge_expectation({'1' => 0}, {'1' => 1}, {'1' => 1})
    end

    it 'none empty, one coincides (min right val)' do
      quick_merge_expectation({'1' => 1}, {'1' => 0}, {'1' => 1})
    end

    it 'multiple coincide (avg use)' do
      hash_1 = {
          a: 1,
          b: 2,
          c: 3,
          d: 4,
          e: 5,
      }
      hash_2 = {
          a: 4,
          b: 3,
          c: 2,
          d: 1,
          e: 7,
      }
      result = {
          a: 4,
          b: 3,
          c: 3,
          d: 4,
          e: 7,
      }
      quick_merge_expectation(hash_1, hash_2, result)
    end

    it 'left has nil' do
      hash_1 = {
          a: 1,
          b: 2,
          c: nil,
          d: 4,
          e: 5,
      }
      hash_2 = {
          a: 4,
          b: 3,
          c: 2,
          d: 1,
          e: 3,
      }
      result = {
          a: 4,
          b: 3,
          c: 2,
          d: 4,
          e: 5,
      }
      quick_merge_expectation(hash_1, hash_2, result)
    end

    it 'right has nil' do
      hash_1 = {
          a: 1,
          b: 2,
          c: 2,
          d: 4,
          e: 5,
      }
      hash_2 = {
          a: 4,
          b: 3,
          c: 2,
          d: 1,
          e: nil,
      }
      result = {
          a: 4,
          b: 3,
          c: 2,
          d: 4,
          e: 5,
      }
      quick_merge_expectation(hash_1, hash_2, result)
    end

    it 'multiple coincide with nil (avg use)' do
      hash_1 = {
          a: 1,
          b: 2,
          c: nil,
          d: 4,
          e: 5,
      }
      hash_2 = {
          a: 4,
          b: 3,
          c: 2,
          d: 1,
          e: nil,
      }
      result = {
          a: 4,
          b: 3,
          c: 2,
          d: 4,
          e: 5,
      }
      quick_merge_expectation(hash_1, hash_2, result)
    end

    def quick_merge_expectation(hash_1, hash_2, merged)
      expect(Artist.depth_merge!(hash_1, hash_2)).to eq(merged)
    end
  end

  describe 'Artist.find_artist' do
    let(:valid_names) {
      [
          'Black Sabbath',
      ]
    }

    let(:invalid_names) {
      %w(sPUKslXlnz pdbPxLK7rt w8yUJnC171 mLvr4IaeC8 ZYR9Z5R967)
    }

    let(:random_array_size_max) { 20 }


    it 'returns nil if we search against an empty array' do
      valid_names.each do |name|
        quick_find_expectation([], name, nil)
      end
    end

    it 'finds an artist when present in a single artist array' do
      valid_names.each do |name|
        artist = build(:artist, name: name)
        artist_array = generate_artist_array(1, { artist: artist })
        quick_find_expectation(artist_array, name, artist)
      end
    end

    it 'finds an artist when present in a single artist array independant of case' do
      artist = build(:artist, name: 'blACk SaBBath')
      artist_array = generate_artist_array(1, { artist: artist })
      quick_find_expectation(artist_array, 'BlAcK SAbbAth', artist)
    end

    it 'fails to find an absent artist in a single artist array' do
      artist_array = generate_artist_array(1)
      invalid_names.each do |invalid|
        quick_find_expectation(artist_array, invalid, nil)
      end
    end

    it 'finds an artist present in a randomly sized array' do
      valid_names.each do |name|
        size = rand(2...random_array_size_max)
        artist = build(:artist, name: name)
        artist_array = generate_artist_array(size, { artist: artist })
        quick_find_expectation(artist_array, name, artist)
      end
    end

    it 'fails to find an artist not present in a randomly sized array' do
      size = rand(2...random_array_size_max)
      artist_array = generate_artist_array(size)
      invalid_names.each do |invalid|
        quick_find_expectation(artist_array, invalid, nil)
      end
    end

    def quick_find_expectation(array, name, expected)
      expect(Artist.find_artist_in_array(array, name)).to eq(expected)
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

  describe 'Artist.collect_related_artists' do
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

  describe 'Artist.search_spotify' do
    let(:artists) { [ 'Black Sabbath', 'Radiohead' ] }
    it 'finds an artists given the artist is on spotify' do
      artist = Artist.search_spotify('Black Sabbath')
      expect(artist.name).to eq('Black Sabbath')
    end

    it 'returns nil if the artist is not on spotify' do
      %w(sPUKslXlnz pdbPxLK7rt w8yUJnC171 mLvr4IaeC8 ZYR9Z5R967).each do |invalid|
        artist = Artist.search_spotify(invalid)
        expect(artist).to be nil
      end
    end

    it 'adds artists it finds to the database' do
      artists.each do |artist|
        expect(Artist.find_by_name(artist)).to be nil
        Artist.lookup_artist(artist)
        expect(Artist.find_by_name(artist)).to_not be_nil
      end
    end
  end

  describe 'Artist.search' do
    let(:invalid_names) { [ nil, '' ] }
    let(:invalid_depths) { (-10..0).to_a }

    it 'returns [{}, {}] for invalid names' do
      invalid_names.each do |name|
        expect(Artist.search(name, 1)).to eq([{}, {}])
      end
    end

    it 'returns [{}, {}] for invalid depths' do
      invalid_depths.each do |depth|
        expect(Artist.search('Black Sabbath', depth)).to eq([{}, {}])
      end
    end
  end



end
