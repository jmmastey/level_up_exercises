require 'sinatra'
require './bomb'

enable :sessions

get '/' do
  session.clear
  erb :index
end

post '/boot' do
  puts params
  session[:bomb] = Bomb.new(params["activation_code"],
    params["deactivation_code"])
  redirect '/bomb'
end

get '/bomb' do
  erb :bomb, locals: { bomb_state: bomb.status }
end

post '/bomb' do
  puts params
  user_input_code = params['user-code']
  bomb.analyze_user_code(user_input_code)
  if bomb.incorrect_deactivation_attempts == 3
    redirect '/exploded'
  else
    erb :bomb, locals: { bomb_state: bomb.status }
  end
end

get '/exploded' do
  erb :exploded
end

def bomb
  session[:bomb]
end
