# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'json'
require_relative 'lib/bomb'
require_relative 'lib/timer'

enable :sessions
set :public_folder, Proc.new { File.join(File.dirname(__FILE__), 'assets') }

get '/' do
  session[:bomb] = nil
  haml :index
end

get '/status' do
  body(server_response(200))
end

get '/explode' do
  body(server_response(200))
end

post '/deploy' do
  params = JSON.parse(request.env["rack.input"].read)
  if !numeric_input?(params["activateCode"]) || !numeric_input?(params["deactivateCode"])
    return server_response(400, "Codes must be numeric.")
  elsif params["activateCode"] == params["deactivateCode"]
    return server_response(400, "Codes cannot match.")
  end
  session[:bomb] = Bomb.new(params["activateCode"], params["deactivateCode"])
  body(server_response(200))
end

post '/activate' do
  params = JSON.parse(request.env["rack.input"].read)
  attempt_activation(params["code"], params["time"])
end

post '/deactivate' do
  params = JSON.parse(request.env["rack.input"].read)
  attempt_deactivation(params["code"])
end

def bomb_status
  bomb = session[:bomb]
  {
    state: bomb.state,
    attempts: bomb.failed_deactivations,
    max_attempts: bomb.max_failed_deactivations,
    detonation_time: bomb.timer.nil? ? -1 : bomb.timer.seconds_remaining,
  }
end

def server_response(code, error_message = "")
  response = {
    status: code,
    error: error_message,
  }
  response.merge!(bomb_status) unless session[:bomb].nil?
  response.to_json
end

def attempt_activation(code, time)
  return server_response(400, "Code must be numeric.") unless numeric_input?(code)
  return server_response(401, "Invalid activation code.") unless session[:bomb].enter_code(code).error.nil?
  session[:bomb].timer = Timer.new(time)
  server_response(200)
end

def attempt_deactivation(code)
  return server_response(400, "Code must be numeric.") unless numeric_input?(code)
  return server_response(401, "Invalid deactivation code.") unless session[:bomb].enter_code(code).error.nil?
  session[:bomb].timer = nil
  server_response(200)
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
