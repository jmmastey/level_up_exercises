# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require './bomb.rb'
require 'json.rb'
require 'sinatra/contrib'

enable :sessions

get '/' do
  redirect('/boot')
end

get '/boot' do
  session[:my_bomb] = Bomb.new
  erb :boot
end

post '/boot' do
  my_bomb = session[:my_bomb]
  my_bomb.boot_bomb
  session[:my_bomb] = my_bomb
  redirect('/activate')
  # add feature that accepts act and deact codes from Villian
end

get '/activate' do
  my_bomb = session[:my_bomb]
  state = my_bomb.bomb_state
  if state
    @state_message = "bomb is #{state.to_s}"
  else
    @state_message = "We're sorry, the bomb is not ready yet. Try again later."
  end
  erb :activate
end

post '/activate' do
  my_bomb = session[:my_bomb]
  state = my_bomb.bomb_state
  if state == :active
    redirect('/deactivate')
  end
  if my_bomb.activate(params[:code])
    @state_message = "Bomb is #{state.to_s}"
    session[:my_bomb] = my_bomb
    redirect('/deactivate')
  else
    @state_message = "Wrong code. Bomb is #{state.to_s}."
  end
  erb :activate
end

route :get, :post, '/deactivate' do
  my_bomb = session[:my_bomb]
  state = my_bomb.bomb_state
  @state_message = "Bomb is #{state.to_s}"
  session[:my_bomb] = my_bomb
  erb :deactivate
end

get '/detonate' do
  erb :detonate
end

post '/state' do
  code = params['input']
  code_is_valid = false
  my_bomb = session[:my_bomb]
  if (my_bomb.bomb_state == :active) && my_bomb.deactivate(code)
    code_is_valid = true
    session[:my_bomb] = my_bomb
  end
  content_type :json
  { valid: code_is_valid }.to_json
end
