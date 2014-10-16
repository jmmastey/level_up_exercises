# run `ruby overlord.rb` to run a webserver for this app
require 'rubygems'
require 'sinatra'
require 'erb'
require 'shotgun'
require_relative 'bomb'

enable :sessions
set :port, 9393
set :bind, '0.0.0.0'

get '/' do
  session[:bomb]= Bomb.new
  @bomb =  session[:bomb]
  erb :bomb_view
end


post '/activate' do
  code = params[:activation_code].to_i
  bomb =  session[:bomb]
  bomb.enter_code(code)
  bomb.activate
  @bomb = session[:bomb]
  erb :bomb_view
end

post '/deactivate' do
  code = params[:deactivation_code].to_i
  bomb = session[:bomb]
  bomb.enter_code(code)
  bomb.deactivate
  @bomb = session[:bomb]
  erb :bomb_view
 end


# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
