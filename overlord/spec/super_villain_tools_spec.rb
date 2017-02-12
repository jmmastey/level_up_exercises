ENV['RACK_ENV'] = 'test'

require 'overlord'  # <-- your sinatra app
require 'rspec'
require 'rack/test'

describe 'The Overlord App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "Bomb creation" do
    it "Creates bomb" do
      get '/create_bomb'
      expect(last_response).to be_ok
      expect(last_response.body).to eq('Bomb Created')
    end
  end
end
