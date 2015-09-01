require 'rails_helper'

RSpec.describe GraphController, type: :controller do
  describe 'POST', '#generate_graph' do
    let(:valid_artists) do
      [
        'Black Sabbath'
      ]
    end

    let(:invalid_artists) do
      [
        'Bak Sabat'
      ]
    end

    let(:bad_depths) do
      [
        'words',
        '',
        nil,
        '-1',
        -1,
        7,
        8
      ]
    end

    # The next two functions ensure GACC on validate_depth
    it 'returns 200 on :valid_artists depth: 0 to 2' do
      valid_artists.each do |artist|
        3.times do |depth|
          post_generate_graph({ name: artist, depth: depth.to_s }, 200)
        end
      end
    end

    it 'returns bad request on :valid_artists on :bad_depths' do
      valid_artists.each do |artist|
        bad_depths.each do |depth|
          post_generate_graph({ name: artist, depth: depth }, 400)
        end
      end
    end

    it 'returns 200 for invalid artist (to display a message) depth: 0 to 2' do
      invalid_artists.each do |invalid|
        3.times do |depth|
          post_generate_graph({ name: invalid, depth: depth }, 200)
        end
      end
    end

    it 'returns 400 for invalid graph on :bad_depths' do
      invalid_artists.each do |invalid|
        bad_depths.each do |depth|
          post_generate_graph({ name: invalid, depth: depth }, 400)
        end
      end
    end

    it 'loads the cached graph whenever possible' do
      # This test assumes graph_controller.setup_graph functions properly.
      valid_artists.each do |artist|
        setup_graph(artist, 1)
        find_artist = Graph.find_by(artist: artist, depth: 1)
        expect(find_artist).to_not be(nil)
        post_generate_graph({ name: artist, depth: 1 }, 200)
      end
    end
  end

  def post_generate_graph(params, status)
    post :generate_graph, params
    expect(response).to have_http_status(status), error(params, status, response)
  end

  def error(params, status, response)
    "Expected posting to graph#generate_graph with params= #{params} "
    "To have status #{status}. Instead, it had status #{response}."
  end

  def setup_graph(name, depth)
    nodes, edges = Graph.search(name, depth)
    nodes_json, edges_json = GraphJSON.new.to_json(nodes, edges)
    Graph.create!(
      artist: name,
      depth: depth,
      nodes: nodes_json,
      edges: edges_json,
    )
  end
end
