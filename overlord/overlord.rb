require 'sinatra'
require 'haml'
require_relative './bomb'
require 'pry'

enable :sessions
set :session_secret, ENV['overlord_secret_key']

get '/' do
  session[:bomb] = nil
  haml :index
end

post '/configure' do
  set_bomb
  halt(422) unless session[:bomb].booted?
  halt(200)
end

post '/activate' do
  bomb = session[:bomb]
  bomb.activate(params['activation_code']) unless bomb.activated?
  halt(422) unless bomb.activated?
  halt(200)
end

post '/deactivate' do
  bomb = session[:bomb]
  bomb.deactivate(params['deactivation_code'])
  halt(200) if bomb.deactivated?
  halt(400) if bomb.exploded?
  session[:bomb] = nil if bomb.deactivated? || bomb.exploded?
  halt(422, "#{bomb.attempts} attempts left")
end

def set_bomb
  if session[:bomb]
    session[:bomb].update_codes(params)
  else
    bomb = Bomb.new(params['activation_code'], params['deactivation_code'])
    session[:bomb] = bomb
  end
end
