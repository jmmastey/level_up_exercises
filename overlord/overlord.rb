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

ACTIVATION_TIME = 8

get '/' do
  redirect '/overlords'
end

get '/overlords' do
  erb :create_bomb_form
end

post '/overlords/create_bomb' do
  session[:bomb] = create_bomb(params)
  session[:bomb_msg] = "Bomb Created"
  session[:timer] = ACTIVATION_TIME
  erb :bomb_status, :locals => get_status
end

post '/overlords/action' do
  record_timer(params)
  action = params[:action]
  send(action, params)
  erb :bomb_status, :locals => get_status
end

def create_bomb(params)
  activation_code = params[:activation_code] || ""
  deactivation_code = params[:deactivation_code] || ""
  Bomb.new(activation_code, deactivation_code)
end

def record_timer(params)
  session[:timer] = params[:timer]
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

def detonate(params)
  session[:bomb_msg] = session[:bomb].detonate
end

def get_status
  bomb = session[:bomb] || Bomb.new
  status = bomb.to_h
  status[:bomb_msg] = session[:bomb_msg]
  status[:timer] = session[:timer]
  status
end

def start_time
  session[:start_time] ||= (Time.now).to_s
end
