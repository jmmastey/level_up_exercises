require 'rails_helper'

RSpec.describe ArtistsController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'loads the index erb file' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #generate_graph' do
    let(:valid_artists) {
      [
          'Black Sabbath',
      ]
    }

    let(:invalid_artists) {
      [
          'Bak Sabat',
      ]
    }

    let(:bad_depths) {
      [
          'words',
          '',
          nil,
          '-1',
          -1,
          7,
          8,
      ]
    }

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
          post_generate_graph({ name: artist, depth: depth}, 400)
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

    it 'returns 400 for invalid artists on :bad_depths' do
      invalid_artists.each do |invalid|
        bad_depths.each do |depth|
          post_generate_graph({ name: invalid, depth: depth }, 400)
        end
      end
    end
  end

  def post_generate_graph(params, status)
    post :generate_graph, params
    expect(response).to have_http_status(status), graph_error(params, status)
  end

  def graph_error(params, status)
    "Expected posting to artists#generate_graph with params= #{params}" << \
    " To have status #{status}"
  end
end
