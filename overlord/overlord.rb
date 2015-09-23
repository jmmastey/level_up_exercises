# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'json'
require_relative 'lib/bomb'

enable :sessions
set :public_folder, Proc.new { File.join(File.dirname(__FILE__), 'assets') }

ERROR_INVALID_CODE = "One or more bomb codes entered were invalid, unable to deploy bomb."

get '/' do
  haml :index
end

get '/status' do
  body(bomb_status_response(200))
end

get '/explode' do
  body(bomb_status_response(200))
end

post '/explode' do
  return unless session[:bomb].state == "Activated"
  session[:bomb].explode_if_timer_out
end

post '/deploy' do
  params = JSON.parse(request.env["rack.input"].read)
  session[:bomb] = Bomb.new(params["activateCode"], params["deactivateCode"])
  body(bomb_status_response(200))
end

post '/activate' do
  params = JSON.parse(request.env["rack.input"].read)
  attempt_activation(params["code"])
end

post '/deactivate' do
  params = JSON.parse(request.env["rack.input"].read)
  attempt_deactivation(params["code"])
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end

def bomb_status_response(code)
  bomb = session[:bomb]
  { 
    status: code,
    state: bomb.state,
    attempts: bomb.failed_deactivations,
    max_attempts: bomb.max_failed_deactivations,
  }.to_json
end

def attempt_activation(code)
  return bomb_status_response(400) unless numeric_input?(code)
  unless session[:bomb].enter_code(code).error.nil?
    return bomb_status_response(401)
  else
    return bomb_status_response(200)
  end
end

def attempt_deactivation(code)
  return bomb_status_response(400) unless numeric_input?(code)
  unless session[:bomb].enter_code(code).error.nil?
    return bomb_status_response(401)
  else
    return bomb_status_response(200)
  end
end

def numeric_input?(code)
  code !~ /\D/
end

def strip_letters(code)
  code.to_s.gsub(/[^\d]/, '')
end

def validate_deployment(params)
  return false if strip_letters(params[:activation_code]).length < 4
  return false if strip_letters(params[:deactivate_code]).length < 4
end
