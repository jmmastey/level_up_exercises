require 'sinatra'
require_relative 'bomb'

enable :sessions

get '/' do
  DEFAULT_ACTIVATION_CODE = Bomb::DEFAULT_ACTIVATION_CODE
  DEFAULT_DEACTIVATION_CODE = Bomb::DEFAULT_DEACTIVATION_CODE
  erb :boot
end

post '/' do
  activation_code = params['activation_code']
  deactivation_code = params['deactivation_code']
  if Bomb.valid_code?(activation_code) && Bomb.valid_code?(deactivation_code)
    session[:bomb] = Bomb.new(params['activation_code'], params['deactivation_code'])
    redirect('/activate')
  else
    @error = "Error: Please enter a four digit number"
  end
  erb :boot
end

get '/activate' do
  @bomb = session[:bomb]
  erb :activate
end

post '/activate' do
  @bomb = session[:bomb]
  @bomb.activate(params['activate_code'])
  if @bomb.status == :active
    redirect('/deactivate')
  else
    @error = "Error: Wrong Activation Code"
  end
  erb :activate
end

get '/deactivate' do
  @bomb = session[:bomb]
  erb :deactivate
end

post '/deactivate' do
  @bomb = session[:bomb]
  @bomb.deactivate(params['deactivate_code'])
  redirect('/activate') if @bomb.status == :inactive
  redirect('/boom') if @bomb.status == :boom
  @error = "Error: Wrong Deactivation Code. You have #{@bomb.remaining_attempts} attempts remaining."
  erb :deactivate
end

get '/boom' do
  erb :boom
end
