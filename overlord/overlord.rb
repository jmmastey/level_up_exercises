# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'haml'
require 'json'
require './lib/bomb'
require './lib/timer'

enable :sessions

CODE_FORMAT_ERROR = ({ "error" => "Codes must be numeric" }).to_json
TIMER_FORMAT_ERROR = ({ "error" => "Time must be positive and numeric" }).to_json
DEFAULT_FAILED_ATTEMPS = 3

get '/' do
  save_to_session(:bomb, nil)
  haml :index
end

get '/boot', provides: :json do
  content_type :json
  return CODE_FORMAT_ERROR unless valid_codes?(params['activation_code'], params['deactivation_code'])
  bomb = initialize_bomb(params['activation_code'], params['deactivation_code'])
  bomb
end

get '/activate', provides: :json do
  content_type :json
  return TIMER_FORMAT_ERROR unless valid_timer?(params['time'])
  bomb = get_from_session(:bomb)
  return bomb.to_json if bomb.active?
  bomb = activate_bomb(bomb, params['code'], params['time'].to_i)
  bomb
end

get '/deactivate', provides: :json do
  content_type :json
  bomb = deactivate_bomb(params['code'])
  bomb
end

get '/state', provides: :json do
  content_type :json
  bomb = get_from_session(:bomb)
  bomb.state
  bomb.to_json
end

def initialize_bomb(activation_code, deactivation_code)
  bomb = Bomb.new(activation_code, deactivation_code, DEFAULT_FAILED_ATTEMPS)
  save_to_session(:bomb, bomb)
  bomb.to_json
end

def activate_bomb(bomb, code, time)
  bomb = bomb.enter_code(code)
  bomb.timer = Timer.new(time) if bomb.active?
  save_to_session(:bomb, bomb)
  bomb.to_json
end

def deactivate_bomb(code)
  bomb = get_from_session(:bomb)
  bomb = bomb.enter_code(code)
  bomb.timer = nil if bomb.inactive?
  save_to_session(:bomb, bomb)
  bomb.to_json
end

def valid_codes?(activation_code, deactivation_code)
  activation_code.match(/^\d+$/) && deactivation_code.match(/^\d+$/)
end

def valid_timer?(time)
  time.match(/^\d+$/) && time.to_i >= 0
end

def save_to_session(key, value)
  session[key] = value
end

def get_from_session(key)
  session[key]
end
