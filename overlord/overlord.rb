# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'haml'
require 'sass'
require 'pp'
require_relative 'bomb'
enable :sessions

get '/' do
  haml :index
end

post '/boot' do
  new_bomb
  session[:bomb].booted(params[:a_code])
end

get '/boot' do
  boot_status = session[:bomb].status(:booted)
  "#{boot_status}"
end

post '/activate' do
  session[:bomb].activated(params[:a_code], params[:d_code], params[:activate])
end

get '/activate' do
  activate_status = session[:bomb].status(:activated)
  "#{activate_status}"
end

post '/deactivate' do
  session[:bomb].deactivate(params[:deactivate])
end

get '/deactivate' do
  deactivate_status = session[:bomb].status(:deactivated)
  exploded_status = session[:bomb].status(:exploded)
  count = session[:bomb].count
  "#{deactivate_status}" + "&#{exploded_status}" + "&#{count}"
end

def new_bomb
  session[:bomb] = Bomb.new
end
