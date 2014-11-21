# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'capybara/rspec'
require_relative 'bomb'

enable :sessions

get '/' do
  session.clear
  erb :index
end

after do
  puts '[Params]'
  p request.params
  p request.session[:bomb]
end

post '/boot' do
  session[:bomb] = Bomb.new(activation_code: params["activation"], deactivation_code: params["deactivation"])
  redirect '/bomb'
end

get '/bomb' do
  erb :bomb, locals: { bomb_state: bomb.status }
end

post '/bomb' do
  user_code_input = params['user-code']
  bomb.match_user_code(user_code_input)
  erb :bomb, locals: { bomb_state: bomb.status }
end

def bomb
  session[:bomb]
end

not_found do
  erb :error
end
