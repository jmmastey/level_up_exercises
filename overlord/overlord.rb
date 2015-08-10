require 'sinatra/base'
require_relative 'lib/bomb'

class Overlord < Sinatra::Base
  enable :sessions

  get '/' do
    bomb = Bomb.instance
    session[:bomb] = bomb
    if bomb.armed?
      redirect "/disarm_bomb"
    else
      erb :outcome
    end
  end

  get '/disarm_bomb' do
    load_session
    erb :disarm_bomb
  end

  post '/disarm_bomb' do
    bomb = Bomb.instance
    session[:bomb] = bomb
    bomb.disarm(params[:disarming_code].to_s)
    if bomb.disarmed? || bomb.detonated?
      erb :outcome
    else
      erb :disarm_bomb
    end
  end

  def load_session
    bomb = Bomb.instance
    session[:bomb] = bomb
  end

  get '/configure_bomb' do
    load_session
    erb :configure_bomb
  end

  post '/boot_bomb' do
    bomb = Bomb.instance
    bomb.boot_bomb
    bomb.configure_arming_code(params[:arming_code].to_s)
    bomb.configure_disarming_code(params[:disarming_code].to_s)
    session[:bomb] = bomb
    erb :configure_bomb
  end

  post '/shutdown_bomb' do
    bomb = Bomb.instance
    bomb.shutdown
    session[:bomb] = bomb
    erb :configure_bomb
  end

  post '/reset_codes' do
    bomb = Bomb.instance
    bomb.configure_arming_code(params[:arming_code_reset].to_s)
    bomb.configure_disarming_code(params[:disarming_code_reset].to_s)
    session[:bomb] = bomb
    erb :configure_bomb
  end

  post '/arm_bomb' do
    bomb = Bomb.instance
    bomb.arm(params[:arming_code].to_s)
    session[:bomb] = bomb
    erb :configure_bomb
  end

  get '/outcome' do
    load_session
    erb :outcome
  end
  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end
