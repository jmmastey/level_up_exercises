# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require './bomb.rb'
require 'pry'
require 'sinatra/flash'

enable :sessions

before do
  @user_bomb = retrieve_bomb
end

after do
  update_bomb(@user_bomb)
end


get '/' do
  return erb :boot_page if !@user_bomb
  return erb :start_bomb_page if @user_bomb.state == :inactive && !@user_bomb.has_been_activated 
  return erb :countdown_page if @user_bomb.state == :active
  return erb :reactivate_page if @user_bomb.state == :inactive && @user_bomb.has_been_activated
  return erb :bomb_exploded if@user_bomb.state == :exploded
end

get '/newbomb' do
  @user_bomb = nil
  redirect '/'
end

post '/attemptboot' do
  begin
    @user_bomb = Bomb.new(params[:activation_code], params[:deactivation_code])
  rescue
    flash[:failed_boot] = "Your activation codes were not accepted. Ensure they are 4 digits."
  end
  redirect '/'
end

post '/startbomb' do
  redirect '/' unless @user_bomb
  @user_bomb.attempt_activation(params[:activation_code])
  flash[:failed_activation] = "Incorrect activation code" if @user_bomb.state == :inactive
  redirect '/'
end


post '/attemptdeactivation' do
  redirect '/' unless @user_bomb.state == :active 
  @user_bomb.attempt_deactivation(params[:deactivation_code])
  if @user_bomb.state == :active
    flash[:failed_deactivation] = "Incorrect deactivation code. \
               #{@user_bomb.num_deactivation_attempts} attempt(s) remain."
  end
  redirect '/' 
end

get '/getremainingtime' do
  @user_bomb.update_remaining_time
  return (@user_bomb.time_remaining).to_s if @user_bomb.time_remaining > 0
end

get '/bombexploded' do
  redirect '/'
end

def retrieve_bomb
  session[:user_bomb] if session[:user_bomb]
end

def update_bomb(bomb)
  session[:user_bomb] = bomb
end
