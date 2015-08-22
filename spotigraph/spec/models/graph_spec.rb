require 'rails_helper'

RSpec.describe Graph, type: :model do
  describe '.depth_merge!' do
    it 'merges two empty hashes correctly' do
      expect(Graph.depth_merge!({}, {})).to eq({})
    end

    it 'merges correctly when the right hash is empty' do
      one_key = { first: 1 }
      expect(Graph.depth_merge!(one_key, {})).to eq(one_key)
    end

    it 'merges correctly when the left hash is empty' do
      one_key = { first: 1 }
      expect(Graph.depth_merge!({}, one_key)).to eq(one_key)
    end

    it 'merges correctly when neither are empty and neither coincide' do
      hash_1 = { first: 1 }
      hash_2 = { second: 2 }
      result = { first: 1, second: 2 }
      expect(Graph.depth_merge!(hash_1, hash_2)).to eq(result)
    end

    it 'merges correctly when passed two copies of the same hash' do
      hash_1 = { first: 1 }
      expect(Graph.depth_merge!(hash_1, hash_1)).to eq(hash_1)
    end

    it 'merges correctly when one key coincides (equal value)' do
      hash_1 = { first: 1 }
      hash_2 = { first: 1 }
      expect(Graph.depth_merge!(hash_1, hash_2)).to eq(hash_1)
    end

    it 'merges correctly when one key coincides (min left val)' do
      hash_1 = { first: 0 }
      hash_2 = { first: 1 }
      expect(Graph.depth_merge!(hash_1, hash_2)).to eq(hash_2)
    end

    it 'merges correctly when one key coincides (min right val)' do
      hash_1 = { first: 1 }
      hash_2 = { first: 0 }
      expect(Graph.depth_merge!(hash_1, hash_2)).to eq(hash_1)
    end

    it 'merges correctly when multiple keys coincide (avg use)' do
      hash_1 = { a: 1, b: 2, c: 3, d: 4, e: 5 }
      hash_2 = { a: 4, b: 3, c: 2, d: 1, e: 7 }
      result = { a: 4, b: 3, c: 3, d: 4, e: 7 }
      expect(Graph.depth_merge!(hash_1, hash_2)).to eq(result)
    end

    it 'merges correctly when left has nil' do
      hash_1 = { a: 1, b: 2, c: nil, d: 4, e: 5 }
      hash_2 = { a: 4, b: 3, c: 2, d: 1, e: 3 }
      result = { a: 4, b: 3, c: 2, d: 4, e: 5 }
      expect(Graph.depth_merge!(hash_1, hash_2)).to eq(result)
    end

    it 'merges correctly when right has nil' do
      hash_1 = { a: 1, b: 2, c: 2, d: 4, e: 5 }
      hash_2 = { a: 4, b: 3, c: 2, d: 1, e: nil }
      result = { a: 4, b: 3, c: 2, d: 4, e: 5 }
      expect(Graph.depth_merge!(hash_1, hash_2)).to eq(result)
    end

    it 'multiple coincide with nil (avg use)' do
      hash_1 = { a: 1, b: 2, c: nil, d: 4, e: 5 }
      hash_2 = { a: 4, b: 3, c: 2, d: 1, e: nil }
      result = { a: 4, b: 3, c: 2, d: 4, e: 5 }
      expect(Graph.depth_merge!(hash_1, hash_2)).to eq(result)
    end
  end

  describe '.search' do
    let(:valid_names) { ['Black Sabbath', 'Radiohead'] }
    let(:invalid_names) do
      [
        nil,
        '',
        '; DROP TABLE graph;',
        "'<script>alert('alert');</script>'",
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
          'Uriah Heep',
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
          'Liars',
        ],
      }
    end
    let(:invalid_depths) { (-10..0).to_a }

    it 'returns valid graph for depths 1 for valid_names' do
      valid_names.each do |name|
        graph = Graph.search(name, 1)[0]
        graph.each do |key, value|
          expect(related_artists[key]).to eq(value)
        end
      end
    end

    it 'returns [{}, {}] for invalid names' do
      invalid_names.each do |name|
        expect(Graph.search(name, 1)).to eq([{}, {}])
      end
    end

    it 'returns [{}, {}] for invalid depths' do
      invalid_depths.each do |depth|
        expect(Graph.search('Black Sabbath', depth)).to eq([{}, {}])
      end
    end
  end
end
