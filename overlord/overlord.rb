# run `ruby overlord.rb` to run a webserver for this app

begin
  require 'sinatra'
rescue LoadError
  require 'rubygems'
  require 'sinatra'
end

require './bomb'

enable :sessions
set :port, 8080
set :bind, '0.0.0.0'

get '/' do
  redirect '/overlords'
end

get '/overlords' do
  erb :create_bomb_form
end

post '/overlords/create_bomb' do
  activation_code = params[:activation_code] || ""
  deactivation_code = params[:deactivation_code] || ""
  session[:bomb] = Bomb.new(activation_code, deactivation_code)
  session[:bomb_msg] = "Bomb Created"
  erb :bomb_status, :locals => get_status
end

post '/overlords/action' do
  case params[:type]
  when 'activate'
    activate(params)
  when 'deactivate'
    deactivate(params)
  when 'snip'
    snip(params)
  end
  erb :bomb_status, :locals => get_status
end

def activate(params)
  code = params[:code] || ""
  session[:bomb_msg] = session[:bomb].activate(code)
end

def deactivate(params)
  code = params[:code] || ""
  session[:bomb_msg] = session[:bomb].deactivate(code)
end

def snip(params)
  session[:bomb_msg] = session[:bomb].snip  
end

def get_status
  bomb = session[:bomb] || Bomb.new
  status = bomb.to_h
  status[:bomb_msg] = session[:bomb_msg]
  status
end

def start_time
  session[:start_time] ||= (Time.now).to_s
end
