# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'haml'
require 'sass'
require 'pp'
require_relative 'app_helper'
require_relative 'bomb'
enable :sessions

get '/' do
	haml :index
end

post '/boot' do
	new_bomb
	puts "params #{params}"
	session[:bomb].booted(params[:activation], params[:deactivation])
	#haml :index
end

post '/activate' do
	session[:bomb].activated
	#haml :index
end

post '/deactivate' do
	session[:bomb].deactivate
end

def new_bomb
	session[:bomb] = Bomb.new
end
