require 'sinatra/base'
require 'Haml'
require_relative 'bomb'
require 'pry'

class Overlord < Sinatra::Base
  enable :sessions
  COUNTDOWN_SECONDS = 30

  get '/' do
    session[:comment_text] = 'Bomb is inactive - configure codes'
    haml :index
  end

  post '/bomb' do
    @set_activecode = params[:setactivationcode]
    @set_deactivecode = params[:setdeactivationcode]
    begin
      session[:bomb] = Bomb.new(@set_activecode, @set_deactivecode)
      session[:comment_text] = ''
      haml :detonator
    rescue ArgumentError
      session[:comment_text] = 'Enter only numeric values.'
      haml :index
    end
  end

  post '/activate' do
    @detonatecode = params[:activationcode]
    session[:bomb].activate?(@detonatecode)
    session[:comment_text] = ''
    if session[:bomb].active
      start_time
      session[:comment_text] = "You have #{COUNTDOWN_SECONDS} seconds and 3 attempts, to enter the right deactivation code."
    else
      session[:comment_text] = 'Incorrect activation code'
    end
    haml :detonator
  end

  post '/deactivate' do
    @deactivatecode = params[:deactivationcode]
    session[:bomb].deactivate(@deactivatecode)
    if !session[:bomb].active && elapsed_time < COUNTDOWN_SECONDS
      session[:comment_text] = ''
      redirect '/'
    else
      check_time
      haml :detonator
    end
  end

  private

  def start_time
    session[:start_time] = (Time.now).to_i
  end

  def elapsed_time
    ((Time.now).to_i - session[:start_time]).to_i
  end

  def check_time
    if elapsed_time > COUNTDOWN_SECONDS
      session[:comment_text] = 'Your time has expired - BOMB exploded!!!'
      session[:bomb].exploded = true
    elsif session[:bomb].attempts >= 3
      session[:comment_text] = 'You have exceeded 3 attempts - BOMB exploded!!!'
    else
      time_left = (COUNTDOWN_SECONDS - elapsed_time).to_i
      attempts_left = 3 - (session[:bomb].attempts).to_i
      session[:comment_text] = "You have #{time_left} seconds and #{attempts_left} attempts, to enter the right deactivation code."
    end
  end
  run! if app_file == $0
end
