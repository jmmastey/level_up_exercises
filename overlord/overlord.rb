# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require './bomb.rb'
require 'pry'

enable :sessions

@@bomb_booted = false

get '/' do
  erb :index
end

get '/bootbomb' do
  erb :boot_page
end

post '/attemptboot' do
  activation_code = params[:activation_code]
  deactivation_code = params[:deactivation_code]
  begin
    @@user_bomb = Bomb.new(activation_code, deactivation_code)
    @@bomb_booted = true
    erb :boot_status
  rescue
    erb :boot_status
  end
end

post '/startbomb' do
  activation_code = params[:activation_code]
  out = @@user_bomb.start_bomb(activation_code)
  if @@user_bomb.active 
    @time_remaining = @@user_bomb.time_remaining
    erb :bomb_status
  else
    @error_message = out
    erb :bomb_status
  end
end
  
post '/attemptdeactivation' do
  deactivation_code = params[:deactivation_code]
  @out = @@user_bomb.attempt_deactivation(deactivation_code)
  if !@@user_bomb.exploded && !@@user_bomb.active
    @reactivation_possible = true
    erb :deactivation_status
  elsif !@@user_bomb.exploded && @@user_bomb.active
    @deactivation_failed = true
    erb :deactivation_status
  else
    @bomb_exploded = true
    erb :bomb_exploded
  end
end

get '/getremainingtime' do
  return (@@user_bomb.get_remaining_time).to_s if @@user_bomb.time_remaining > 0
  erb :bomb_exploded
end



# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time]  ||= (Time.now).to_s
end
