require 'sinatra'
require './bomb'

enable :sessions

get '/' do
  session.clear
  erb :index
end

post '/boot' do
  session[:bomb] = Bomb.new(activation_code: params["activation"],
                            deactivation_code: params["deactivation"])
  redirect '/bomb'
end

get '/bomb' do
  erb :bomb, locals: { bomb_state: bomb.status }
end

post '/bomb' do
  user_input_code = params['user-code']
  bomb.analyze_user_code(user_input_code)
  if bomb.incorrect_deactivation_attempts == 3
    redirect '/exploded'
  else
    erb :bomb, locals: { bomb_state: bomb.status }
  end
end

get '/exploded' do
  session.clear
  erb :exploded
end

not_found do
  erb :error
end

def bomb
  session[:bomb]
end
