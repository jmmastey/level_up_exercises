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
    it 'returns http success' do
      get :generate_graph
      expect(response).to have_http_status(:success)
    end
  end
end
