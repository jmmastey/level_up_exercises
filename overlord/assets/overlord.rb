# run `ruby overlord.rb` to run a webserver for this app
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'json'
require_relative 'bomb'

enable :sessions

get '/' do
  haml :index, locals: { bomb: initiate_bomb }
end

get '/status' do
  body(create_response(200))
end

post '/' do
  if session[:bomb].state == "Deactivated"
    body(attempt_activation(params[:code]))
  elsif session[:bomb].state == "Activated"
    body(attempt_deactivation(params[:code]))
  end
end

post '/explode' do
  return unless session[:bomb].state == "Activated"
  session[:bomb].explode_if_timer_out
end

def attempt_activation(code)
  return create_response(400) unless numeric_input?(code)
  if session[:bomb].activate(code)
    create_response(200)
  else
    create_response(401)
  end
end

def attempt_deactivation(code)
  return create_response(400) unless numeric_input?(code)
  if session[:bomb].deactivate(code)
    create_response(200)
  else
    create_response(401)
  end
end

def create_response(code)
  bomb = session[:bomb]
  { status: code, state: bomb.state,
    attempts_remaining: bomb.attempts_remaining,
    timer_end: bomb.timer_end }.to_json
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end

def initiate_bomb
  # For custom codes, change to Bomb.new(<activate_code>, <deactivate_code>)
  session[:bomb] ||= Bomb.new
end

def numeric_input?(code)
  code !~ /\D/
end
