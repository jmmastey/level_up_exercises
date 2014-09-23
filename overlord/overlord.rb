# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require_relative "bomb"

enable :sessions

get '/' do
  erb :index
end

get '/bomb' do
  erb :bomb
end

post '/set-codes' do
  session[:bomb] = Bomb.new(params[:activation_code], params[:deactivation_code])
  @bomb = session[:bomb]
  erb :bomb
end

post '/activate' do
  session[:bomb].activate(params[:code])
  @bomb = session[:bomb]
  erb :bomb
end

post '/deactivate' do
  session[:bomb].deactivate(params[:code])
  @bomb = session[:bomb]
  erb :bomb
end

post '/snip-wires' do
  session[:bomb].snip_wires
  @bomb = session[:bomb]
  erb :bomb
end

