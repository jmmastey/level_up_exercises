require 'rails_helper'

describe EventsController, type: :controller do
  let(:message_403) do
    'The action you were trying to perform is restricted (403)'
  end

  describe 'GET index' do
    it 'render all upcomming runnning events' do
      get :index
      expect(response).to be_success
      expect(response).to render_template(:index)
    end
  end

  describe 'GET page' do
    before(:each) do
      get :index
      expect(response).to render_template(:index)
    end
    it 'render 403 when make non-ajax request' do
      get :page, page_num: 2
      expect(response).to render_template(file: "#{Rails.root}/public/403.html")
      expect(response.body).to include(message_403)
    end
    it 'render js when make ajax request' do
      xhr :get, :page, page_num: 2, format: 'js'
      expect(response.content_type).to eq(Mime::JS)
    end
  end

  describe 'GET filter' do
    before(:each) do
      get :index
      expect(response).to render_template(:index)
    end
    it 'render 403 when make non-ajax request' do
      get :filter, start_date: '', end_date: ''
      expect(response).to render_template(file: "#{Rails.root}/public/403.html")
      expect(response.body).to include(message_403)
    end
    it 'render js when make ajax request' do
      xhr :get, :filter, start_date: '', end_date: '', format: 'js'
      expect(response.content_type).to eq(Mime::JS)
    end
  end
end
