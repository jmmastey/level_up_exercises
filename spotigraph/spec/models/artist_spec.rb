require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'Artist.depth_merge!' do
    it 'merges two empty hashes correctly' do
      expect(Artist.depth_merge!({}, {})).to eq({})
    end

    it 'merges correctly when the right hash is empty' do
      one_key = { first: 1 }
      expect(Artist.depth_merge!(one_key, {})).to eq(one_key)
    end

    it 'merges correctly when the left hash is empty' do
      one_key = { first: 1 }
      expect(Artist.depth_merge!({}, one_key)).to eq(one_key)
    end

    it 'merges correctly when neither are empty and neither coincide' do
      hash_1 = { first: 1 }
      hash_2 = { second: 2 }
      result = { first: 1, second: 2 }
      expect(Artist.depth_merge!(hash_1, hash_2)).to eq(result)
    end

    it 'merges correctly when passed two copies of the same hash' do
      hash_1 = { first: 1 }
      expect(Artist.depth_merge!(hash_1, hash_1)).to eq(hash_1)
    end

    it 'merges correctly when one key coincides (equal value)' do
      hash_1 = { first: 1 }
      hash_2 = { first: 1 }
      expect(Artist.depth_merge!(hash_1, hash_2)).to eq(hash_1)
    end

    it 'merges correctly when one key coincides (min left val)' do
      hash_1 = { first: 0 }
      hash_2 = { first: 1 }
      expect(Artist.depth_merge!(hash_1, hash_2)).to eq(hash_2)
    end

    it 'merges correctly when one key coincides (min right val)' do
      hash_1 = { first: 1 }
      hash_2 = { first: 0 }
      expect(Artist.depth_merge!(hash_1, hash_2)).to eq(hash_1)
    end

    it 'merges correctly when multiple keys coincide (avg use)' do
      hash_1 = { a: 1, b: 2, c: 3, d: 4, e: 5 }
      hash_2 = { a: 4, b: 3, c: 2, d: 1, e: 7 }
      result = { a: 4, b: 3, c: 3, d: 4, e: 7 }
      expect(Artist.depth_merge!(hash_1, hash_2)).to eq(result)
    end

    it 'merges correctly when left has nil' do
      hash_1 = { a: 1, b: 2, c: nil, d: 4, e: 5 }
      hash_2 = { a: 4, b: 3, c: 2, d: 1, e: 3 }
      result = { a: 4, b: 3, c: 2, d: 4, e: 5 }
      expect(Artist.depth_merge!(hash_1, hash_2)).to eq(result)
    end

    it 'merges correctly when right has nil' do
      hash_1 = { a: 1, b: 2, c: 2, d: 4, e: 5 }
      hash_2 = { a: 4, b: 3, c: 2, d: 1, e: nil }
      result = { a: 4, b: 3, c: 2, d: 4, e: 5 }
      expect(Artist.depth_merge!(hash_1, hash_2)).to eq(result)
    end

    it 'multiple coincide with nil (avg use)' do
      hash_1 = { a: 1, b: 2, c: nil, d: 4, e: 5 }
      hash_2 = { a: 4, b: 3, c: 2, d: 1, e: nil }
      result = { a: 4, b: 3, c: 2, d: 4, e: 5 }
      expect(Artist.depth_merge!(hash_1, hash_2)).to eq(result)
    end
  end

  describe 'Artist.find_artist' do
    let(:valid_names) { ['Black Sabbath', 'Radiohead'] }

    # Note, Faker will not generate names of this form
    let(:invalid_names) do
      %w(sPUKslXlnz pdbPxLK7rt w8yUJnC171 mLvr4IaeC8 ZYR9Z5R967)
    end

    let(:random_array_size_max) { 20 }

    it 'returns nil if we search against an empty array' do
      valid_names.each do |name|
        expect(Artist.find_artist_in_array([], name)).to eq(nil)
      end
    end

    it 'finds an artist when present in a single artist array' do
      valid_names.each do |name|
        artist = build(:artist, name: name)
        artist_array = generate_artist_array(1, artist: artist)
        expect(Artist.find_artist_in_array(artist_array, name)).to eq(artist)
      end
    end

    it 'finds an artist when present independent of case' do
      name = 'BlAcK SAbbAth'
      artist = build(:artist, name: 'blACk SaBBath')
      artist_array = generate_artist_array(1, artist: artist)
      expect(Artist.find_artist_in_array(artist_array, name)).to eq(artist)
    end

    it 'returns nil when the artist is not present in the array' do
      artist_array = generate_artist_array(1)
      invalid_names.each do |invalid|
        expect(Artist.find_artist_in_array(artist_array, invalid)).to eq(nil)
      end
    end

    it 'finds an artist present in a randomly sized array' do
      valid_names.each do |name|
        size = rand(2...random_array_size_max)
        artist = build(:artist, name: name)
        artist_array = generate_artist_array(size, artist: artist)
        expect(Artist.find_artist_in_array(artist_array, name)).to eq(artist)
      end
    end

    it 'fails to find an artist not present in a randomly sized array' do
      size = rand(2...random_array_size_max)
      artist_array = generate_artist_array(size)
      invalid_names.each do |invalid|
        expect(Artist.find_artist_in_array(artist_array, invalid)).to eq(nil)
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
    let(:artists) { %w(Radiohead Mixtapes) }
    let(:not_on_spotify) do
      %w(sPUKslXlnz pdbPxLK7rt w8yUJnC171 mLvr4IaeC8 ZYR9Z5R967)
    end

    it 'finds an artists given the artist is on spotify' do
      artist = Artist.search_spotify('Black Sabbath')
      expect(artist.name).to eq('Black Sabbath')
    end

    it 'returns nil if the artist is not on spotify' do
      not_on_spotify.each do |invalid|
        artist = Artist.search_spotify(invalid)
        expect(artist).to be nil
      end
    end

    it 'adds artists it finds to the database' do
      # If this test is failing, ensure that you haven't modified the seed file.
      # Seed file is loaded for testing, and some artists will already be in db.
      # This test ensures that we properly add encountered artists to the db.
      artists.each do |artist|
        expect(Artist.find_by_name(artist)).to be nil
        Artist.lookup_artist(artist)
        expect(Artist.find_by_name(artist)).to_not be_nil
      end
    end
  end

  describe 'Artist.search' do
    let(:valid_names) { ['Black Sabbath', 'Radiohead'] }
    let(:invalid_names) do
      [
        nil,
        '',
        '; DROP TABLE artists;',
        "'<script>alert('alert');</script>'"
      ]
    end
    let(:related_artists) do
      {
        'Black Sabbath' => [
          'Ozzy Osbourne',
          'Judas Priest',
          'Dio',
          'Iron Maiden',
          'Motörhead',
          'Danzig',
          'Deep Purple',
          'Thin Lizzy',
          'KISS',
          'Saxon',
          'Heaven & Hell',
          'AC/DC',
          'Rainbow',
          'Metallica',
          'Bruce Dickinson',
          'Tony Iommi',
          'UFO',
          'Diamond Head',
          'Alice Cooper',
          'Uriah Heep'
        ],
        'Radiohead' => [
          'Thom Yorke',
          'Portishead',
          'Muse',
          'Björk',
          'Pixies',
          'Interpol',
          'Atoms For Peace',
          'Beck',
          'Four Tet',
          'Joy Division',
          'The Flaming Lips',
          'Grizzly Bear',
          'The National',
          'The xx',
          'The Smiths',
          'Burial',
          'R.E.M.',
          'Elbow',
          'St. Vincent',
          'Liars'
        ],
        'Ozzy Osbourne' => [
          'Black Sabbath',
          'Dio',
          'Judas Priest',
          'KISS',
          'Iron Maiden',
          'Twisted Sister',
          'Alice Cooper',
          'Scorpions',
          'Whitesnake',
          'Mötley Crüe',
          'Rainbow',
          'Bruce Dickinson',
          'Deep Purple',
          'Skid Row',
          'AC/DC',
          'Queensrÿche',
          'Motörhead',
          'Saxon',
          'Quiet Riot',
          "\"Ugly Kid Joe"
        ]
      }
    end
    let(:invalid_depths) { (-10..0).to_a }

    it 'returns valid graph for depths 1 for valid_names' do
      valid_names.each do |name|
        graph = Artist.search(name, 1)[0]
        graph.each do |key, value|
          expect(related_artists[key]).to eq(value)
        end
      end
    end

    it 'works correctly for a path length of 2' do
      graph = Artist.search('Black Sabbath', 2)[0]
      expect(graph['Ozzy Osbourne']).to eq(related_artists['Ozzy Osbourne'])
    end

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
