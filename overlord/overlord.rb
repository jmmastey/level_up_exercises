require 'sinatra'
require 'haml'
require 'json'

class Overlord < Sinatra::Base
  configure do
    enable :sessions
    set :views, "#{File.dirname(__FILE__)}/views"
    set :public_dir, "#{File.dirname(__FILE__)}/public"
    set :session_secret, "http://open.spotify.com/track/1hR0fIFK2qRG3f3RF70pb7"
  end

  # www methods

  get '/' do
    session[:bomb_state] ||= 'inactive'
    @bomb_state = 'Bomb is ' + session[:bomb_state]
    haml :index
  end

  # api methods

  before '/api/*' do
    content_type :json
  end

  get '/api/state' do
    do_json(:session => session.to_hash)
  end

  post '/api/state' do
    state = session[:bomb_state]
    code = params[:pass]
    state = params[:state]

    session[:bomb_state] = 'active' if CODES[:activation].include?(code)
    session[:bomb_state] = 'inactive' if CODES[:deactivation].include?(code)

    do_json(:session => session.to_hash)
  end

  private

  def do_json(data)
    { :data => data }.to_json
  end

  CODES = {
    :activation => ['1234'],
    :deactivation => ['0000'],
  }
end
