require 'rails_helper'

RSpec.describe GraphController, type: :controller do
  describe 'GET', '#generate_graph' do
    let(:valid_artists)   { TestData.valid_artists }
    let(:invalid_artists) { TestData.invalid_artists }
    let(:invalid_depths)  { TestData.invalid_depths }

    it 'returns 200 on :valid_artists depth: 0 to 2' do
      valid_artists.each do |artist|
        3.times do |depth|
          params = generate_params(artist, depth)
          status = 200
          get :generate_graph, params
          expect(response).to have_http_status(status),
                              error(params, status, response)
        end
      end
    end

    it 'returns 400 for invalid artists on :invalid_depths' do
      invalid_artists.each do |invalid|
        invalid_depths.each do |depth|
          next if invalid == ''      # The only exception (redirects to root)
          params = generate_params(invalid, depth)
          status = 400
          get :generate_graph, params
          expect(response).to have_http_status(status),
                              error(params, status, response)
        end
      end
    end

    it 'returns 400 on :valid_artists on :invalid_depths' do
      valid_artists.each do |artist|
        invalid_depths.each do |depth|
          params = generate_params(artist, depth)
          status = 400
          get :generate_graph, params
          expect(response).to have_http_status(status),
                              error(params, status, response)
        end
      end
    end

    it 'returns 200 for invalid artist (to display a message) depth: 0 to 2' do
      invalid_artists.each do |invalid|
        3.times do |depth|
          params = generate_params(invalid, depth)
          status = 200
          get :generate_graph, params
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
        params = generate_params(artist, 1)
        status = 200
        get :generate_graph, params
        expect(response).to have_http_status(status),
                            error(params, status, response)
      end
    end
  end

  describe 'POST', '#search_graph' do
    let(:valid_artists)   { TestData.valid_artists }
    let(:invalid_artists) { TestData.invalid_artists }
    let(:invalid_depths)  { TestData.invalid_depths }

    it 'returns 400 for invalid artists on :invalid_depths' do
      invalid_artists.each do |invalid|
        invalid_depths.each do |depth|
          next if invalid == ''      # The only exception (redirects to root)
          params = { name: invalid, depth: depth }
          status = 400
          post :search_graph, params
          expect(response).to have_http_status(status),
                              error(params, status, response)
        end
      end
    end

    it 'returns 400 on :valid_artists on :invalid_depths' do
      valid_artists.each do |artist|
        invalid_depths.each do |depth|
          params = { name: artist, depth: depth }
          status = 400
          post :search_graph, params
          expect(response).to have_http_status(status),
                              error(params, status, response)
        end
      end
    end

    it 'redirects for invalid artist (to display a message) depth: 0 to 2' do
      invalid_artists.each do |invalid|
        3.times do |depth|
          next if invalid == ''      # The only exception (redirects to root)
          post_redirect_search_graph(invalid, depth)
        end
      end
    end

    it 'redirects valid_artists on depth 0 to 2' do
      valid_artists.each do |name|
        3.times do |depth|
          post_redirect_search_graph(name, depth)
        end
      end
    end
  end

  def post_redirect_search_graph(name, depth)
    url_name = URI.escape(name)
    url_depth = URI.escape(depth.to_s)
    post :search_graph, name: name, depth: depth
    expect(response).to redirect_to("/graph/#{url_name}/#{url_depth}")
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

  def generate_params(artist, depth)
    {
      name: URI.escape(artist.to_s),
      depth: URI.escape(depth.to_s),
    }
  end

  # Give a useful error message. Almost a necessity with each it block doing
  # multiple assertions.
  def error(params, status, response)
    "Expected posting to graph#generate_graph with params= #{params} "
    "To have status #{status}. Instead, it had status #{response}."
  end
end
