# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require './bomb.rb'
#class MyOverlord < Sinatra::Application

enable :sessions

get '/' do
  #"Time to build an app around here. Countdown! Start time: " + start_time
  session[:my_bomb] = Bomb.new
  #erb :home
end


get '/boot' do
  erb :boot
end

get '/activate' do
  my_bomb = session[:my_bomb]
  state = my_bomb.bomb_state
  if state
    @state_message = "bomb is #{state}"
  else
    @state_message = "We're sorry, the bomb is not ready yet. Try again later."
  end

  erb :activate
end

get '/deactivate' do
  my_bomb = session[:my_bomb]

  if my_bomb.deactivate(params[:code]) 
    @state_message = "Bomb is #{my_bomb.bomb_state}" 
    session[:my_bomb] = my_bomb
    redirect('/activate')
  else
    @state_message = "Wrong activation code. Bomb is #{my_bomb.bomb_state}. Try again."
  end
  erb :deactivate
end

get '/detonate' do
  erb :detonate
end


post '/boot' do
  my_bomb = session[:my_bomb]
  p my_bomb
  my_bomb.boot_bomb
  session[:my_bomb] = my_bomb
  redirect('/activate')

  # add feature that accepts act and deact codes from Villian
end

post '/activate' do
  my_bomb = session[:my_bomb]
  if my_bomb.bomb_state == "Active"
    redirect('/deactivate')
  end
  if my_bomb.activate(params[:code]) 
    @state_message = "Bomb is #{my_bomb.bomb_state}" 
    session[:my_bomb] = my_bomb
    redirect('/deactivate')
  else
    @state_message = "Wrong activation code. Bomb is #{my_bomb.bomb_state}. Try again."
  end
  # if code is correct, then redirect('/deactivate')  else stay on :activate
  erb :activate
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end

#end
