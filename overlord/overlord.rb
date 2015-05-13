# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require './bomb.rb'
require 'pry'

enable :sessions

get '/' do
  session[:user_bomb] = nil
  erb :boot_page
end

post '/attemptboot' do
  activation_code = params[:activation_code]
  deactivation_code = params[:deactivation_code]
  begin
    @user_bomb = Bomb.new(activation_code, deactivation_code)
    update_bomb(@user_bomb)
    erb :start_bomb_page
  rescue
    erb :boot_page_failed
  end
end

post '/startbomb' do
  @user_bomb = retrieve_bomb
  return erb :boot_page unless @user_bomb
  activation_code = params[:activation_code]
  @user_bomb.start_bomb(activation_code)
  update_bomb(@user_bomb)
  if @user_bomb.state == "active"
    erb :countdown_page
  else
    erb :start_bomb_page_failed
  end
end

post '/attemptdeactivation' do
  @user_bomb = retrieve_bomb
  return erb :boot_page unless @user_bomb
  return erb :start_bomb_page if @user_bomb.state == "inactive"
  deactivation_code = params[:deactivation_code]
  @user_bomb.attempt_deactivation(deactivation_code)
  update_bomb(@user_bomb)
  return erb :reactivate_page if @user_bomb.state == "inactive"
  return erb :countdown_page_error if @user_bomb.state == "active"
  return erb :bomb_exploded if @user_bomb.state == "exploded"
end

get '/getremainingtime' do
  @user_bomb = retrieve_bomb
  @user_bomb.update_remaining_time
  update_bomb(@user_bomb)
  return (@user_bomb.time_remaining).to_s if @user_bomb.time_remaining > 0
end

get '/bombexploded' do
  @user_bomb = retrieve_bomb
  return erb :boot_page unless @user_bomb
  return erb :countdown_page if @user_bomb.state == "active"
  return erb :start_bomb_page if @user_bomb.state == "inactive"
  return erb :bomb_exploded if @user_bomb.state == "exploded"
end

def retrieve_bomb
  session[:user_bomb]
end

def update_bomb(bomb)
  session[:user_bomb] = bomb
end
