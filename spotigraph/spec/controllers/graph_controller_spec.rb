require 'rails_helper'

RSpec.describe GraphController, type: :controller do
  describe 'POST', '#generate_graph' do

    let(:valid_artists)   { TestData.valid_artists }
    let(:invalid_artists) { TestData.invalid_artists }
    let(:invalid_depths)  { TestData.invalid_depths }

    it 'returns 200 on :valid_artists depth: 0 to 2' do
      valid_artists.each do |artist|
        3.times do |depth|
          params = { name: artist, depth: depth.to_s }
          status = 200
          post :generate_graph, params
          expect(response).to have_http_status(status),
                              error(params, status, response)
        end
      end
    end

    it 'returns bad request on :valid_artists on :invalid_depths' do
      valid_artists.each do |artist|
        invalid_depths.each do |depth|
          params = { name: artist, depth: depth }
          status = 400
          post :generate_graph, params
          expect(response).to have_http_status(status),
                              error(params, status, response)
        end
      end
    end

    it 'returns 200 for invalid artist (to display a message) depth: 0 to 2' do
      invalid_artists.each do |invalid|
        3.times do |depth|
          params = { name: invalid, depth: depth }
          status = 200
          post :generate_graph, params
          expect(response).to have_http_status(status),
                              error(params, status, response)
        end
      end
    end

    it 'returns 400 for invalid graph on :invalid_depths' do
      invalid_artists.each do |invalid|
        invalid_depths.each do |depth|
          params = { name: invalid, depth: depth }
          status = 400
          post :generate_graph, params
          expect(response).to have_http_status(status),
                              error(params, status, response)
        end
      end
    end

    it 'loads the cached graph whenever possible' do
      # This test assumes graph_controller.setup_graph functions properly.
      valid_artists.each do |artist|
        setup_graph(artist, 1)
        find_artist = Graph.find_by(artist: artist, depth: 1)
        # Ensure that the artist is currently not in the db
        expect(find_artist).to_not be(nil)
        params = { name: artist, depth: 1 }
        status = 200
        post :generate_graph, params
        expect(response).to have_http_status(status),
                            error(params, status, response)
      end
    end
  end

  # Give a useful error message. Almost a necessity with each it block doing
  # multiple assertions.
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
