# run `ruby overlord.rb` to run a webserver for this app

require 'json'
require 'sinatra'
require './classes/bomb.rb'
# require './classes/timer.rb'

enable :sessions

get '/index' do
  # session[:timer] = Timer.new(120)
  session[:bomb] = Bomb.new
  haml :index, locals: { bomb: session[:bomb] }
end

get '/hack' do
  b = params[:binary].split(//).map(&:to_i)
  p = params[:panel].to_i

  content_type :json
  { 'success' => session[:bomb].attempt_hack(b, p),
    'done' => session[:bomb].state == 3 }.to_json
end

get '/entercode' do
  success = false
  if session[:bomb].attempts_remain > 0
    if session[:bomb].armed?
      success = session[:bomb].disarm(params[:code])
    else
      success = session[:bomb].arm(params[:code])
    end
  end

  # session[:timer].toggle if success

  content_type :json
  response = { success: success }
  response[:attempts_remain] = session[:bomb].attempts_remain
  response[:state] = session[:bomb].state_to_s

  response.to_json
end

# get '/timeremain' do
#   session[:timer].tick

#   content_type :json
#   response = {}
#   mins = session[:timer].remain / 60
#   secs = session[:timer].remain - mins * 60
#   response[:mins] = mins
#   response[:secs] = secs

#   response.to_json
# end

post "/setcodes" do
  content_type :json

  response = { success: false, message: "Codes already set." }
  response.to_json if session[:bomb].codes_set?
  params[:arm] =  params[:arm] == '' ? '1234' : params[:arm]
  params[:disarm] =  params[:disarm] == '' ? '0000' : params[:disarm]

  num_expr = /[0-9]{4}/
  if !(params[:arm] =~ num_expr)
    response[:message] = "Invalid arm code."
  elsif !(params[:disarm] =~ num_expr)
    response[:message] = "Invalid disarm code."
  else
    session[:bomb].secret_codes(params)
    response[:success] = true
    response[:message] = "Codes have been set."
  end

  response.to_json
end
