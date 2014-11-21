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
  p request.session[:incorrect_attempts]
end

post '/boot' do
  session.clear
  session[:incorrect_attempts] = 0
  session[:bomb] = Bomb.new(activation_code: params["activation"], deactivation_code: params["deactivation"])
  redirect '/bomb'
end

get '/bomb' do
  erb :bomb, locals: { bomb_state: bomb.status }
end

post '/bomb' do
  user_code_input = params['user-code']
  compare_code(user_code_input)
  erb :bomb, locals: { bomb_state: bomb.status }
end

def bomb
  session[:bomb]
end

def compare_code(user_code)
  if bomb.match_activation_code?(user_code)
    bomb.activate
  else
    session[:incorrect_attempts] += 1
    bomb.explode! if session[:incorrect_attempts] == 3
  end
end

not_found do
  erb :error
end
