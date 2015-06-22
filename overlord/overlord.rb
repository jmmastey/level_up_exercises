# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'sinatra/flash'
require './bomb'

enable :sessions

BOMB_NOT_BOOTED = "The bomb has not been booted"
BOMB_ALREADY_BOOTED = "The bomb has already been booted"
INVALID_ACTIVATION_CODE = "Activation codes must be numeric"
INCORRECT_ACTIVATION_CODE = "Incorrect activation code"

def flash_message(message)
  flash[:error] = message
end

def set_session
  session[:bomb] = session[:bomb]
end

def check_status
  loop do
    set_session
    redirect '/explosion' if session[:bomb].status == "Exploded"
    sleep 1
  end
end

def validate_boot_step
  flash_message(BOMB_NOT_BOOTED) unless session[:bomb].booted?
end

def validate_activation_code(code)
  if code =~ /\A\d+\z/ || code == ''
    true
  else
    flash_message(INVALID_ACTIVATION_CODE)
    false
  end
end

def validate_code(code)
  flash_message(INCORRECT_ACTIVATION_CODE) if code != session[:bomb].activation_code
end

get '/' do
  redirect '/reset' unless session[:bomb]
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
  is_valid = validate_activation_code(params[:activation_code])
  args = {
    activation_code: params[:activation_code],
    deactivation_code: params[:deactivation_code],
  }
  begin
    session[:bomb].boot(args) if session[:username] == "villain" && is_valid
  rescue BootError
    flash_message(BOMB_ALREADY_BOOTED)
  end
  redirect '/bomb'
end

post '/apply_code' do
  validate_code(params[:code])
  validate_activation_code(params[:code])
  validate_boot_step
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
