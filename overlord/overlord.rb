# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require_relative "bomb"

enable :sessions

get '/' do
  erb :index
end

post '/set-codes' do
  session[:bomb] = Bomb.new(activation_code: params[:activation_code].to_i,
                            deactivation_code: params[:deactivation_code].to_i)
  @bomb = session[:bomb]
  erb :toggle_bomb
end

post '/activate' do
  session[:bomb].activate(params[:code].to_i)
  @bomb = session[:bomb]
  erb :toggle_bomb
end

post '/deactivate' do
  session[:bomb].deactivate(params[:code].to_i)
  @bomb = session[:bomb]
  erb :toggle_bomb
end

