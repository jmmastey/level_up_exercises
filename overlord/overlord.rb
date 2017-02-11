# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'haml'
require 'json'
require './lib/bomb'
require './lib/timer'

enable :sessions

ERROR = { "error" => "Codes must be numeric" }

get '/' do
  haml :index
end

get '/boot', provides: :json do
  content_type :json
  bomb = initialize_bomb(params['activation_code'], params['deactivation_code'])
  bomb.to_json
end

get '/activate', provides: :json do
  content_type :json
  bomb = get_from_session(:bomb)
  return bomb.to_json if bomb.active?
  bomb = activate_bomb(bomb, params['code'], params['time'].to_i)
  bomb.to_json
end

get '/deactivate', provides: :json do
  content_type :json
  bomb = deactivate_bomb(params['code'])
  bomb.to_json
end

get '/state', provides: :json do
  content_type :json
  bomb = get_from_session(:bomb)
  bomb.state
  bomb.to_json
end

def initialize_bomb(activation_code, deactivation_code)
  return ERROR unless valid_codes(activation_code, deactivation_code)
  bomb = Bomb.new(activation_code, deactivation_code, 3)
  save_to_session(:bomb, bomb)
  bomb
end

def activate_bomb(bomb, code, time)
  bomb = bomb.enter_code(code)
  bomb.timer = Timer.new(time) if bomb.active?
  save_to_session(:bomb, bomb)
  bomb
end

def deactivate_bomb(code)
  bomb = get_from_session(:bomb)
  bomb = bomb.enter_code(code)
  bomb.timer = nil if bomb.inactive?
  save_to_session(:bomb, bomb)
  bomb
end

def valid_codes(activation_code, deactivation_code)
  activation_code.match(/^\d+$/) && deactivation_code.match(/^\d+$/)
end

def save_to_session(key, value)
  session[key] = value
end

def get_from_session(key)
  session[key]
end
