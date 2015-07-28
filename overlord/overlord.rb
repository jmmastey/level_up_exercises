require 'sinatra'
require 'haml'
require_relative './bomb'
require 'json'
require 'pry'

enable :sessions
set :session_secret, ENV['overlord_secret_key']

get '/' do
  session[:bomb] = nil
  haml :index
end

post '/configure' do
  set_bomb
  bomb.boot
  halt(200, "OK".to_json) if bomb.booted?
  halt(422, { 'errors' => bomb.errors }.to_json)
end

post '/activate' do
  bomb.activate(params['activation_code'])
  halt(200, "OK".to_json) if bomb.activated?
  halt(422, { 'errors' => bomb.errors }.to_json)
end

post '/deactivate' do
  bomb.deactivate(params['deactivation_code'])
  halt(200, "OK".to_json) if bomb.deactivated?
  halt(400, { 'status' => "Exploded" }.to_json) if bomb.exploded?
  halt(422, { 'errors' => bomb.errors,
              'attempts' => "#{bomb.attempts} attempts left" }.to_json)
end

def set_bomb
  if bomb
    bomb.update(params['activation_code'], params['deactivation_code'])
  else
    session[:bomb] = Bomb.new(params['activation_code'],
      params['deactivation_code'])
  end
end

def bomb
  session[:bomb]
end
