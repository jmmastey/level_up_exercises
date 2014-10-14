require 'sinatra'
enable :sessions

get '/' do
  erb :initialize
end

get '/initialize' do
  erb :initialize
end

post '/initialize' do
  reset_all_attempts
  session[:activation_code] = params[:activation_code]
  session[:deactivation_code] = params[:deactivation_code]
  session[:bomb_status] = :configured
  erb :activate
end

post '/activate' do
  increment_attempts

  if params[:activation_code] == session[:activation_code]
    activated_bomb
  elsif excessive_attempts?
    explode_bomb
  else
    erb :activate
  end
end

post '/deactivate' do
  increment_attempts

  if session[:bomb_status] == :exploded
    explode_bomb
  end

  if params[:deactivation_code] != session[:deactivation_code] &&
      excessive_attempts?
    explode_bomb
  elsif params[:deactivation_code] == session[:deactivation_code]
    deactivated_bomb
  else
    erb :bomb_activated
  end
end

get '/exploded' do
  explode_bomb
end

post '/snippy' do
  deactivated_bomb
end

def excessive_attempts?
  session[:count] == 3
end

def increment_attempts
  session[:count] = session[:count] + 1
end

def reset_all_attempts
  session[:count] = 0
end

def explode_bomb
  session[:bomb_status] = :exploded
  erb :exploded
end

def deactivated_bomb
  reset_all_attempts
  session[:bomb_status] = :deactivated
  erb :deactivated
end

def activated_bomb
  reset_all_attempts
  session[:bomb_status] = :activated
  erb :bomb_activated
end
