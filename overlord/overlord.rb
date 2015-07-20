require 'sinatra'
require 'pry'
require 'haml'
require 'json'
require_relative './bomb'

set :public_folder, 'public'
enable :sessions
set :session_secret, ENV['overlord_secret_key']


get '/' do
  haml :index
end

post '/configure', provides: :json do
  bomb = Bomb.new(params['activation_code'], params['deactivation_code'])
  if bomb.booted?
    session[:bomb] = bomb
    halt 200
  else
    halt 422
  end
end

post '/activate', provides: :json do
  @bomb = session[:bomb]
  @bomb.activate(params['activation_code']) unless @bomb.activated?
  if @bomb.activated?
    halt 200
  else
    halt 422
  end
end

post '/deactivate', provides: :json do
  @bomb = session[:bomb]
  @bomb.deactivate(params['deactivation_code'])
  if @bomb.deactivated?
    halt 200
  elsif @bomb.exploded?
    halt 400
  else
    halt 422
  end
end

get '/safe' do
  haml :safe
end

get '/exploded' do
  haml :exploded
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
