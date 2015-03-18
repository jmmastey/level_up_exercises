# run `ruby overlord.rb` to run a webserver for this app
require "sinatra"
require_relative "models/Bomb"

enable :sessions, :logging

get '/' do
  "Time to build an app around here. Start time: " + start_time
  redirect "/config"
end

get '/config' do
  erb :config
end

post '/config' do
  @act_code = params[:act]
  @dact_code = params[:deact]
  bomb = Bomb.new(activate_code: @act_code, deactivate_code: @dact_code)
  session[:activate_code] = bomb.activate_code
  session[:deactivate_code] = bomb.deactivate_code
  session[:status] = bomb.status
  session[:attempts] = bomb.attempts
  redirect "/activate"
end

get '/activate' do
  @status = session[:status]
  erb :activation
end

post '/activate' do
  @user_submit = params[:user_submit]
  bomb_status = bomb.activate(@user_submit)
  session[:status] = bomb_status
  puts session[:status]
  redirect "/activate" if bomb_status.eql?('inactive')
  redirect "/deactivate" if bomb_status.eql?('active')
end

get '/deactivate' do
  bomb.status = session[:status]
  erb :deactivation
end

post '/deactivate' do
  bomb.status = session[:status]
  @user_submit_de = params[:user_submit_de]
  bomb.deactivate(@user_submit_de)
  session[:attempts] += 1 if bomb.status.eql?('active')
  redirect "/explode" if session[:attempts] > 2
  redirect "/config" if bomb.status.eql?('inactive')
  redirect "/deactivate" if bomb.status.eql?('active')
end

get '/explode' do
  'KABOOM!'
end

not_found do
  status 404
  'Nothing here'
end

def start_time
  session[:start_time] ||= (Time.now).to_s
end

def bomb
  @bomb ||= Bomb.new(activate_code: session[:activate_code], deactivate_code: session[:deactivate_code])
end
