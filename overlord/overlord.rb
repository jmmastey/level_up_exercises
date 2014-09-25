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

ACTIVATION_TIME = 10

before do
  record_timer(params)
end

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
  erb :bomb_status, :locals => local_session_variables
end

post '/overlords/activate' do
  activate(params)
  erb :bomb_status, :locals => local_session_variables
end

post '/overlords/deactivate' do
  deactivate(params)
  erb :bomb_status, :locals => local_session_variables
end

post '/overlords/snip' do
  snip
  erb :bomb_status, :locals => local_session_variables
end

post '/overlords/detonate' do
  detonate
  erb :bomb_status, :locals => local_session_variables
end

def create_bomb(params)
  respond = Respond.new("responses.json")
  activation_code = params[:activation_code] || ""
  deactivation_code = params[:deactivation_code] || ""
  Bomb.new(respond, activation_code, deactivation_code)
end

private

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

def snip()
  session[:bomb_msg] = session[:bomb].snip
end

def detonate()
  session[:bomb_msg] = session[:bomb].detonate
end

def local_session_variables
  variables = session_bomb.to_h
  variables[:bomb_msg] = session[:bomb_msg]
  variables[:timer] = session[:timer]
  variables
end

def session_bomb
  session[:bomb] || Bomb.new
end
