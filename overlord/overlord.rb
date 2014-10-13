# run `ruby overlord_spec.rb` to run a webserver for this app

require 'sinatra'

enable :sessions

get '/' do
  erb :initialize
end

get '/initialize' do
  erb :initialize
end

get '/activate' do
  erb :activate
end

get '/deactivate' do
  erb :deactivate
end

post '/initialize' do
  session[:count] = 1
  session[:activation_code] = params[:activation_code]
  session[:deactivation_code] = params[:deactivation_code]
  if (session[:deactivation_code] == nil || session[:deactivation_code] == "")
    session[:deactivation_code] = "0000"
  end
  if (session[:activation_code] == nil || session[:activation_code] == "")
    session[:activation_code] = "1234"
  end

  session[:bomb_status] = :configured
  erb :activate
end

post '/activate' do
  act_code = params[:act_code]
  if act_code!=session[:activation]
    if session[:count] >= 3
      erb :bomb_activated
    else session[:count] = session[:count] + 1
    erb :bomb_activated
    end
  else erb :bomb_activated
  end
end

def increment_bomb_activation_counter
  session[:count] = session[:count] + 1
end

def validate_activation_code(code)
  if session[:activation_code] != code
    "wrong code"
    increment_bomb_activation_counter
  end
end

post '/deactivate' do
  if session[:bomb_status] == :exploded
    erb :exploded
  end

  if (params[:deactivation_code] != session[:deactivation_code] &&
      session[:count] >= 3)
    session[:bomb_status] = :exploded
    erb :exploded
  end

  if params[:deactivation_code] != session[:deactivation_code]
    erb :bomb_activated
  end

end


get '/exploded' do
  session[:bomb_status] = :exploded
  erb :exploded
end

post '/snippy' do
  session[:bomb_status] = :deactivated
  erb :deactivated
end
