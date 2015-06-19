# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'sinatra/flash'
require './bomb'

enable :sessions

BOMB_NOT_BOOTED = "The bomb has not been booted"
BOMB_ALREADY_BOOTED = "The bomb has already been booted"
INVALID_ACTIVATION_CODE = "Activation codes must be numeric"
INCORRECT_ACTIVATION_CODE = "Incorrect activation code"

def set_session
  session[:bomb] = session[:bomb]
end

def check_status
  while true
    set_session
    redirect '/explosion' if session[:bomb].status == "Exploded"
    sleep 1
  end
end

def valid_activation_code(code)
  code =~ /\A\d+\z/ || code == '' ? true : false
end

get '/' do
  redirect '/reset' if !session[:bomb]
  redirect '/bomb' if session[:username]
  erb :login
end

post '/login' do
  session[:username] = params[:username]
  redirect '/bomb'
end

get '/logout' do
  session[:username] = nil
  redirect '/'
end

get '/bomb' do
  redirect '/' unless session[:username]
  erb :bomb
end

post '/boot' do
  flash[:invalid_activation_code] = INVALID_ACTIVATION_CODE if !valid_activation_code(params[:activation_code])
  args = { 
    activation_code: params[:activation_code],
    deactivation_code: params[:deactivation_code] 
  }
  begin
    session[:bomb].boot(args) if session[:username] == "villain"
  rescue BootError
    flash[:bomb_already_booted] = BOMB_ALREADY_BOOTED
  end
  redirect '/bomb'
end

post '/apply_code' do
  flash[:bomb_not_booted] = BOMB_NOT_BOOTED unless session[:bomb].booted?
  flash[:invalid_activation_code] = INVALID_ACTIVATION_CODE if !valid_activation_code(params[:code]) && session[:bomb].status == "Inactive"
  flash[:incorrect_activation_code] = INCORRECT_ACTIVATION_CODE if params[:code] != session[:bomb].activation_code
  session[:bomb].apply_code(params[:code])
  redirect '/bomb'
end


get '/reset' do
  session[:status_thread].kill if session[:status_thread]
  session[:status_thread] = Thread.new { check_status }
  session.clear
  session[:bomb] = Bomb.new
  redirect '/'
end
