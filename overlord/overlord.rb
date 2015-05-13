# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require './bomb.rb'
require 'pry'

enable :sessions

get '/' do
  session[:user_bomb] = nil
  erb :index
end

get '/bootbomb' do
  erb :boot_page
end

post '/attemptboot' do
  activation_code = params[:activation_code]
  deactivation_code = params[:deactivation_code]
  begin
    @user_bomb = Bomb.new(activation_code, deactivation_code)
    update_bomb(@user_bomb)
    erb :boot_status
  rescue
    erb :boot_status
  end
end

post '/startbomb' do
  @user_bomb = retrieve_bomb
  return erb :boot_page unless @user_bomb
  activation_code = params[:activation_code]
  out_message = @user_bomb.start_bomb(activation_code)
  locals = { bomb: @user_bomb, error_message: out_message }
  if @user_bomb.active
    update_bomb(@user_bomb)
    erb :bomb_status, locals: locals
  else
    update_bomb(@user_bomb)
    erb :bomb_status, locals: locals
  end
end

post '/attemptdeactivation' do
  @user_bomb = retrieve_bomb
  return erb :boot_page unless @user_bomb
  return erb :boot_status if @user_bomb && !@user_bomb.active
  deactivation_code = params[:deactivation_code]
  out_message = @user_bomb.attempt_deactivation(deactivation_code)
  locals = { exploded: @user_bomb.exploded,
               active: @user_bomb.active,
              message: out_message }
  # either failed to deactivate or can now reactivate (bomb hasn't exploded)
  if !@user_bomb.exploded
    update_bomb(@user_bomb)
    erb :deactivation_status, locals: locals
  else
    update_bomb(@user_bomb)
    erb :bomb_exploded
  end
end

get '/getremainingtime' do
  @user_bomb = retrieve_bomb
  @user_bomb.update_remaining_time
  update_bomb(@user_bomb)
  return (@user_bomb.time_remaining).to_s if @user_bomb.time_remaining > 0
end

get '/bombexploded' do
  @user_bomb = retrieve_bomb
  locals = { bomb: @user_bomb }
  return erb :boot_status unless @user_bomb
  return erb :boot_status if @user_bomb && !@user_bomb.active && !@user_bomb.exploded
  return erb :bomb_status, locals: locals if @user_bomb && @user_bomb.active
  return erb :bomb_exploded
end

def retrieve_bomb
  session[:user_bomb]
end

def update_bomb(bomb)
  session[:user_bomb] = bomb
end
