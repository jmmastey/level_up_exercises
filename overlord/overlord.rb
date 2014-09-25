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
ALLOWED_ACTIONS = ['activate', 'deactivate', 'snip', 'detonate']


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

post '/overlords/action' do
  record_timer(params)
  action = get_valid_action(params)
  send(action, params) if action
  erb :bomb_status, :locals => local_session_variables
end

post '/overlords/activate' do
  record_timer(params)
  activate(params)
  erb :bomb_status, :locals => local_session_variables
end

post '/overlords/deactivate' do
  record_timer(params)
  deactivate(params)
  erb :bomb_status, :locals => local_session_variables
end

post '/overlords/snip' do
  record_timer(params)
  snip
  erb :bomb_status, :locals => local_session_variables
end

post '/overlords/detonate' do
  record_timer(params)
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

def get_valid_action(params)
  action = params[:action]
  return action if ALLOWED_ACTIONS.include?(action)
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

def start_time
  session[:start_time] ||= (Time.now).to_s
end
