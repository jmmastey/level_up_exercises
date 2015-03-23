# run `ruby overlord.rb` to run a webserver for this app
require "sinatra"
require_relative "models/bomb"

enable :sessions, :logging

get '/' do
  "Time to build an app around here. Start time: " + start_time
  redirect "/config"
end

get '/config' do
  erb :config
end

post '/config' do
  bomb = Bomb.new(activate_code: params[:act], deactivate_code:  params[:deact])
  session[:bomb] = bomb
  redirect "/activate"
end

get '/activate' do
  @status = session[:bomb].status
  erb :activation
end

post '/activate' do
  bomb_status = session[:bomb].activate(params[:user_submit])
  redirect back if bomb_status.eql?('inactive')
  redirect "/deactivate" if bomb_status.eql?('active')
end

get '/deactivate' do
  erb :deactivation
end

post '/deactivate' do
  session[:bomb].deactivate(params[:user_submit_de])
  redirect "/explode" if session[:bomb].status.eql?('explode')
  redirect "/config" if session[:bomb].status.eql?('inactive')
  redirect back if session[:bomb].status.eql?('active')
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
