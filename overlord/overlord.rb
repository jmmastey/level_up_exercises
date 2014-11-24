require 'sinatra'
require 'capybara/rspec'
require './bomb'

enable :sessions

# For debugging purposes

after do
  puts '[Params]'
  p request.params
  p request.session[:bomb]
end

get '/' do
  session.clear
  erb :index
end

post '/boot' do
  session[:bomb] = Bomb.new(activation_code: params["activation"], deactivation_code: params["deactivation"])
  redirect '/bomb'
end

get '/bomb' do
  erb :bomb, locals: { bomb_state: bomb.status }
end

post '/bomb' do
  user_input_code = params['user-code']
  bomb.analyze_user_code(user_input_code)
  erb :bomb, locals: { bomb_state: bomb.status }
end

not_found do
  erb :error
end

def bomb
  session[:bomb]
end
