require 'rails_helper'


RSpec.describe Graph, type: :model do
  describe '.depth_merge!' do
    it 'merges two empty hashes correctly' do
      expect(Graph.depth_merge!({}, {})).to eq({})
    end

    it 'merges correctly when the right hash is empty' do
      one_key = { a: 1 }
      expect(Graph.depth_merge!(one_key, {})).to eq(one_key)
    end

    it 'merges correctly when the left hash is empty' do
      one_key = { a: 1 }
      expect(Graph.depth_merge!({}, one_key)).to eq(one_key)
    end

    it 'merges correctly when neither are empty and neither coincide' do
      hash_1 = { a: 1 }
      hash_2 = { b: 2 }
      result = { a: 1, b: 2 }
      expect(Graph.depth_merge!(hash_1, hash_2)).to eq(result)
    end

    it 'merges correctly when passed two copies of the same hash' do
      hash_1 = { a: 1 }
      expect(Graph.depth_merge!(hash_1, hash_1)).to eq(hash_1)
    end

    it 'merges correctly when one key coincides (equal value)' do
      hash_1 = { a: 1 }
      hash_2 = { a: 1 }
      expect(Graph.depth_merge!(hash_1, hash_2)).to eq(hash_1)
    end

    it 'merges correctly when one key coincides (min left val)' do
      hash_1 = { a: 0 }
      hash_2 = { a: 1 }
      expect(Graph.depth_merge!(hash_1, hash_2)).to eq(hash_2)
    end

    it 'merges correctly when one key coincides (min right val)' do
      hash_1 = { a: 1 }
      hash_2 = { a: 0 }
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
    let(:valid_artists) { TestData.valid_artists }
    let(:related_artists) { TestData.valid_artists_related }
    let(:invalid_artists) { TestData.invalid_artists }
    let(:invalid_depths) { TestData.invalid_depths }

    it 'returns valid graph for depths 1 for valid_artists' do
      valid_artists.each do |name|
        graph = Graph.search(name, 1)[0]
        graph.each do |key, value|
          expect(value).to eq(related_artists[key]),
                           search_error(name, value, related_artists[key])
        end
      end
    end

    it 'returns [{}, {}] for invalid names' do
      invalid_artists.each do |name|
        expect(Graph.search(name, 1)).to eq([{}, {}])
      end
    end

    it 'returns [{}, {}] for invalid depths' do
      invalid_depths.each do |depth|
        expect(Graph.search('Black Sabbath', depth)).to eq([{}, {}])
      end
    end
  end

  def search_error(name, value, related)
    "Expected #{name} to have related artists \n#{related}, instead it has \n#{value}"
  end
end
