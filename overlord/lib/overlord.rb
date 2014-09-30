# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require_relative 'bomb'

enable :sessions

def bomb
  session[:bomb] ||= Bomb.new
end

get '/' do
  erb :index, layout: :layout_no_header
end

get '/inactivated' do
  erb bomb.status
end

get '/attempts_remaining' do
  erb :attempts_remaining, :layout => false
end

post '/restart' do
  session[:bomb] = Bomb.new
  redirect '/inactivated'
end

post '/activate' do
  begin
    bomb.activate(params[:activation_code], params[:deactivation_code])
  rescue ArgumentError => @activation_error

  rescue Bomb::BombError => @bomb_error

  end
  erb bomb.status
end

post '/deactivate' do
  begin
    bomb.deactivate(params[:deactivation_code])
    @bomb_error = "Incorrect deactivation code" if bomb.activated?
  rescue Bomb::BombError => @bomb_error

  end
  erb bomb.status
end
