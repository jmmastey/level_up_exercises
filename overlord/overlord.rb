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
  body(bomb_status_response(200))
end

get '/explode' do
  body(bomb_status_response(200))
end

post '/deploy' do
  params = JSON.parse(request.env["rack.input"].read)
  if !numeric_input?(params["activateCode"]) || !numeric_input?(params["deactivateCode"])
    return bomb_status_response(400, "Codes must be numeric.")
  elsif params["activateCode"] == params["deactivateCode"]
    return bomb_status_response(400, "Codes cannot match.")
  end
  session[:bomb] = Bomb.new(params["activateCode"], params["deactivateCode"])
  body(bomb_status_response(200))
end

post '/activate' do
  params = JSON.parse(request.env["rack.input"].read)
  attempt_activation(params["code"], params["time"])
end

post '/deactivate' do
  params = JSON.parse(request.env["rack.input"].read)
  attempt_deactivation(params["code"])
end

def bomb_status_response(code, error_message = "")
  bomb = session[:bomb]

  bomb_status = {
    status: code,
    error: error_message,
  }

  unless bomb.nil?
    bomb_status.merge!({ 
      state: bomb.state,
      attempts: bomb.failed_deactivations,
      max_attempts: bomb.max_failed_deactivations,
      detonation_time: bomb.timer.nil? ? -1 : bomb.timer.seconds_remaining
    })
  end

  bomb_status.to_json
end

def attempt_activation(code, time)
  return bomb_status_response(400, "Code must be numeric.") unless numeric_input?(code)
  unless session[:bomb].enter_code(code).error.nil?
    return bomb_status_response(401, "Invalid activation code.")
  else
    session[:bomb].timer = Timer.new(time)
    return bomb_status_response(200)
  end
end

def attempt_deactivation(code)
  return bomb_status_response(400, "Code must be numeric.") unless numeric_input?(code)
  unless session[:bomb].enter_code(code).error.nil?
    return bomb_status_response(401, "Invalid deactivation code.")
  else
    session[:bomb].timer = nil
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
