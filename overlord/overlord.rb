# run `ruby overlord.rb` to run a webserver for this app
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
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
  if session[:bomb].state == "Activated"
    session[:bomb].explode if timer_ran_out?
  end
end

def attempt_activation(code)
  return create_response(400) unless numeric_input?(code)
  if session[:bomb].correct_activation_code?(code)
    activate_bomb
  else
    create_response(401)
  end
end

def attempt_deactivation(code)
  return create_response(400) unless numeric_input?(code)
  if session[:bomb].correct_deactivation_code?(code)
    deactivate_bomb
  else
    invalid_deactivate_attempt
  end
end

def create_response(code)
  string = "{\"status\":#{code}, \"state\":\"#{session[:bomb].state}\","
  string << "\"attempts_remaining\":#{session[:bomb].attempts_remaining},"
  string << "\"timer_end\":#{session[:bomb].timer_end}}"
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

def activate_bomb
  session[:bomb].activate
  create_response(200)
end

def deactivate_bomb
  session[:bomb].deactivate
  create_response(200)
end

def timer_ran_out?
  session[:bomb].timer_end - Time.now.to_i <= 0
end

def invalid_deactivate_attempt
  session[:bomb].decrement_attempt
  attempts = session[:bomb].attempts_remaining
  session[:bomb].explode if attempts == 0
  create_response(401)
end
