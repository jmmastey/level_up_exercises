# run `ruby overlord.rb` to run a webserver for this app
require 'rubygems'
require 'sinatra'
require 'erb'
require 'shotgun'
# require 'sinatra/flash'
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
  code = params[:activation_code]
  if is_valid_code?(code)
    bomb =  session[:bomb]
    bomb.enter_code(code.to_i)
    bomb.activate
  end
  @bomb = session[:bomb]
  erb :bomb_view
end

post '/deactivate' do
  code = params[:deactivation_code]
  puts 
  if is_valid_code?(code)
  bomb = session[:bomb]
  bomb.enter_code(code.to_i)
  bomb.deactivate
 end
  @bomb = session[:bomb]
  erb :bomb_view
 end

def is_valid_code?(code)
  /\A[0-9]{4}\Z/.match(code)
end


# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
