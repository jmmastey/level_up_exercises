
# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require_relative 'bomb.rb'
require 'pry'
require 'sinatra/flash'
enable :sessions
set :bind, '0.0.0.0'
FAILED_BOOT_MESSAGE = 'Please enter 4 digit numbers'
get '/' do
  erb :overlord_boot_page
end

post '/attemptboot' do
  session[:bomb]  = Bomb.new
  session[:bomb].activation_code = params[:activation_code]
  session[:bomb].deactivation_code = params[:deactivation_code]
  flash[:failed_boot] = FAILED_BOOT_MESSAGE unless session[:bomb].valid_boot_codes?(session[:bomb].activation_code,session[:bomb].deactivation_code)
  redirect '/'  unless session[:bomb].valid_boot_codes?(session[:bomb].activation_code, session[:bomb].deactivation_code)
  erb :overlord_start_bomb  if session[:bomb].valid_boot_codes?(session[:bomb].activation_code, session[:bomb].deactivation_code)
end

post '/startbomb' do
  session[:bomb].entered_activation_code = params[:entered_activation_code]
  return erb :overlord_start_bomb if session[:bomb].activate_code(session[:bomb].activation_code, session[:bomb].entered_activation_code) == 'inactive'
  return erb :overlord_countdown_page if session[:bomb].activate_code(session[:bomb].activation_code, session[:bomb].entered_activation_code) == 'active'
end

post '/attemptdeactivation' do
  session[:bomb].entered_deactivation_code = params[:entered_deactivation_code]
  return erb :overlord_bomb_exploded if params[:countdown] == 'over'
  return erb :overlord_reactivate_page if session[:bomb].deactivate_code(session[:bomb].deactivation_code, session[:bomb].entered_deactivation_code) == 'inactive'
  return erb :overlord_bomb_exploded if session[:bomb].wrong_deactivate_attempts == 3
  return erb :overlord_countdown_page if session[:bomb].wrong_deactivate_attempts < 3
end
