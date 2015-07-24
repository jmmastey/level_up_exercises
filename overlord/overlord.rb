# run `ruby overlord.rb` to run a webserver for this app

require 'json'
require 'sinatra'
require './classes/bomb.rb'

enable :sessions

get '/index' do
  session[:bomb] = Bomb.new
  haml :index, locals: { bomb: session[:bomb] }
end

get '/hack' do
  binary_digits = params[:binary].split(//).map(&:to_i)
  panel_number = params[:panel].to_i

  content_type :json
  { 
    success: session[:bomb].attempt_hack(binary_digits, panel_number),
    done: session[:bomb].state == 3 
  }.to_json
end

get '/entercode' do
  response = { success: entered_code_matched?(params) }
  response[:attempts_remain] = session[:bomb].attempts_remain
  response[:state] = session[:bomb].state_to_s

  content_type :json
  response.to_json
end

post "/setcodes" do
  params[:arm] =  '1234' if params[:arm].empty?
  params[:disarm] =  '0000' if params[:disarm].empty?

  response = set_code_response(params)
  session[:bomb].secret_codes(params) if response[:success]

  content_type :json
  response.to_json
end

def set_code_response(params)
  response = { success: false, msg: "" }

  if session[:bomb].codes_set?
    response[:msg] = "Codes already set."
  elsif !codes_valid?(params)
    response[:msg] = "Codes must be 4 numeric digits."
  else
    response[:msg] = "Codes have been set."
    response[:success] = true
  end

  response
end

def entered_code_matched?(params)
  return false if session[:bomb].attempts_remain == 0

  session[:bomb].disarm(params[:code]) if session[:bomb].armed?
  session[:bomb].arm(params[:code]) if session[:bomb].disarmed?
end

def codes_valid?(params)
  num_expr = /^[0-9]{4}$/

  valid_arm_code = params[:arm] =~ num_expr
  valid_disarm_code = params[:disarm] =~ num_expr

  valid_arm_code && valid_disarm_code
end
