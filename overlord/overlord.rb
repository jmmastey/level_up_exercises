# run `ruby overlord.rb` to run a webserver for this app
require 'haml'
require 'sinatra'

enable :sessions

get '/' do
  session[:bomb] = Bomb.new unless session[:bomb]
  haml :index
end

post '/configure' do
  set_bomb(params)
end

post '/activate' do
end

post '/deactivate' do
end

def set_bomb(params)
  bomb = session[:bomb]
  bomb.boot_up(params[:activation_code], params[:deactivation_code])
end