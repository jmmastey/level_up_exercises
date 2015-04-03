# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require '../overlord/bomb'
require 'pry'
enable :sessions

get '/' do
  erb :home
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

get '/explode' do
  bomb = session[:bomb]
  bomb.explode
  erb :explode
end

post '/' do
  redirect('/configure')
  erb :home
end

post '/configure' do
  activate_code = activation_code
  deactivate_code = deactivation_code

  if Bomb.valid_code?(activate_code) && Bomb.valid_code?(deactivate_code)
    session[:bomb] = Bomb.new(activate_code, deactivate_code)
    redirect('/activate')
  else
    @error_msg = "Invalid codes. Only numbers that are 4 characters long are allowed."
  end
  erb :configure
end

post '/activate' do
  bomb = session[:bomb]
  session[:countdown] = bomb.countdown
  bomb.reset_retry
  bomb.activate(params[:activate_code])
  redirect('/deactivate') if bomb.status == "ACTIVE"
  @error_msg = "Wrong activation code!!"
  erb :activate
end

post '/deactivate' do
  session[:countdown] = params[:d2].chomp('s').to_i
  bomb = session[:bomb]
  bomb.deactivate(params[:deactivate_code])
  redirect('/activate') if bomb.status == "INACTIVE"
  count = bomb.retry_count
  tries = bomb.retry_limit - count
  bomb.explode if tries < 1
  redirect('/explode') if bomb.status == "EXPLODE"
  @error_msg = "Wrong deactivation code!! You have #{tries} tries remaining."
  erb :deactivate
end

def activation_code
  code = params[:activation_code]
  code.empty? ? Bomb.default_activation_code : code
end

def deactivation_code
  code = params[:deactivation_code]
  code.empty? ? Bomb.default_deactivation_code : code
end
