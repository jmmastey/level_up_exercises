# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'pry'

enable :sessions

get '/' do
  erb :configure
end

get '/configure' do
  erb :configure
end

get '/activate' do
  erb :activate
end

get '/deactivate' do
  erb :deactivate
end

post '/configure' do
  session[:count] = 0
  session[:activation] = params[:activation]
  session[:deactivation] = params[:deactivation]
  if (session[:deactivation] == nil || session[:deactivation] == "")
    session[:deactivation] = "0000"
  end  
  if (session[:activation] == nil || session[:activation] == "")
    session[:activation] = "1234"
  end
  erb :activate
end


post '/activate' do
  act_code = params[:act_code]
  if act_code!=session[:activation] 
    if session[:count] >= 3
      erb :activate_three_attempts
 	else session[:count] = session[:count] + 1
      erb :go_back
    end
   else erb :activate_bomb
   end
end

post '/activate_bomb' do
  deact_code = params[:deact_code]
  if (deact_code == "0000" || deact_code == session[:deactivation])
    erb :deactivate_bomb
  else
    "wrong deactivation code"
  end
end

post '/deactivate_bomb' do
  erb :deactivate_bomb
end

get '/bomb_exploded' do
  erb :bomb_exploded
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end


