require 'sinatra/base'
require "pry"
require_relative "models/bomb"

class Overlord < Sinatra::Base
  enable :sessions

  before '/bomb/*' do
    redirect "/exploded" if bomb_exploded?
  end

  get '/' do
    erb :new_bomb
  end

  post '/bomb' do
    @bomb = bomb(params[:bomb])
    redirect "/bomb/inactive"
  end

  get '/bomb/inactive' do
    @bomb = bomb
    erb :inactive_bomb
  end

  post '/bomb/activate' do
    @bomb = bomb
    bomb.activate(params[:activation_code])
    if bomb.active?
      bomb.start_timer
      bomb.messages = nil
      redirect "bomb/active"
    else
      bomb.messages = "Incorrect code - bomb not active"
      redirect '/bomb/inactive'
    end
  end

  get '/bomb/active' do
    @bomb = bomb
    erb :active_bomb
  end

  post '/bomb/deactivate' do
    @bomb = bomb
    bomb.deactivate(params[:deactivation_code])
    if @bomb.active?
      bomb.deactivation_attempts += 1
      bomb.messages = "Incorrect code - ur still gonna blow!"
      redirect "/bomb/active"
    else
      bomb.reset_timer
      bomb.messages = "Bomb has been deactivated"
      redirect '/bomb/inactive'
    end
  end

  get "/exploded" do
    "<h1>Everyone's dead</h1> <br> <h2>It's a cold world.</h2>"
  end

  # ==================================================

  def bomb(options = {})
    session[:bomb] ||= Bomb.new(options)
  end

  def bomb_exploded?
    bomb.too_many_deactivation_attempts? || bomb.timer_ended?
  end

  run! if app_file == $PROGRAM_NAME
end
