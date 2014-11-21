# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'capybara/rspec'
require_relative 'bomb'

enable :sessions

get '/' do
  erb :index
end

after do
  puts '[Params]'
  p request.params
  p request.session[:bomb]
end

post '/boot' do
  session.clear
  user_activation_code = params["activation"] || "1234"
  user_deactivation_code = params["deactivation"] || "0000"
  session[:bomb] = bomb(user_activation_code, user_deactivation_code)
  redirect '/bomb'
end

get '/bomb' do
  erb :bomb, locals: { bomb_state: bomb_state }
end

post '/bomb' do
  user_code_input = params['user-code']
  compare_code(user_code_input)

  erb :bomb, locals: { bomb_state: bomb_state }
end

def bomb(activation_code, deactivation_code)
  session[:bomb] ||= Bomb.new(activation_code: activation_code, deactivation_code: deactivation_code)
end

def bomb_state
  session[:bomb].status.to_s
end

def compare_code(user_code)
  activate_bomb if match_activation_code?(user_code)
end

def activate_bomb
  session[:bomb].status = :active
end

def match_activation_code?(user_code)
  user_code == session[:bomb].activation_code
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end

not_found do
  erb :error
end

#@start_time = start_time

