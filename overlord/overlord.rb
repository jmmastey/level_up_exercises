# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require './bomb.rb'

enable :sessions

get '/' do
  #"Time to build an app around here. Start time: " + start_time
  @greeter = "Welcome Mr/Ms Overlord!"
  @instruction = "Click the button when you are ready to boot the bomb."
  erb :index
end

get '/bootbomb' do
  erb :activation_page
end

post '/attemptactivation' do
  activation_code = params[:activation_code]
  deactivation_code = params[:deactivation_code]
  begin
    @@user_bomb = Bomb.new(activation_code, deactivation_code)
    erb :activation_status_successful
  rescue
    erb :activation_status_unsuccessful
  end
end

post '/startbomb' do
  activation_code = params[:activation_code]
  out = @@user_bomb.start_bomb(activation_code)
  if out == true
    @time_remaining = @@user_bomb.time_remaining
    erb :bomb_status
  else
    @error_message = out
    erb :error_page
  end
end
  
post '/attemptdeactivation' do
  deactivation_code = params[:deactivation_code]
  @out = @@user_bomb.attempt_deactivation(deactivation_code)
  if !@@user_bomb.exploded && !@@user_bomb.active
    erb :reactivation_option
  elsif !@@user_bomb.exploded && @@user_bomb.active
    erb :deactivation_status
  else
    erb :bomb_exploded
  end
end

post '/attemptreactivation' do
  activation_code = params[:activation_code]
  out = @@user_bomb.restart_bomb(activation_code)
  @time_remaining = @@user_bomb.time_remaining
  if out.class != String
    erb :bomb_status
  else
    @error_message = out
    erb :error_page
  end
end












# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time]  ||= (Time.now).to_s
end
