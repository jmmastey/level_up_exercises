require 'sinatra/base'
require_relative 'lib/bomb'

class Overlord < Sinatra::Base
  enable :sessions

  get '/' do
    if session[:bomb]
      redirect "/disarm_bomb"
    else
      'Nothing to do here.'
    end
  end

  def load_session
    bomb = Bomb.instance
    session[:bomb] = bomb
  end

  get '/villain' do
    load_session
    erb :villain
  end

  get '/boot_bomb' do
    load_session
    erb :boot_bomb
  end

  post '/boot_bomb' do
    bomb = Bomb.instance
    bomb.boot_bomb
    bomb.configure_arming_code(params[:arming_code])
    bomb.configure_disarming_code(params[:disarming_code])
    session[:bomb] = bomb
    erb :villain
  end

  get '/shutdown_bomb' do
    load_session
    erb :shutdown_bomb
  end

  post '/shutdown_bomb' do
    bomb = Bomb.instance
    bomb.shutdown
    session[:bomb] = bomb
    erb :villain
  end

  get '/reset_codes' do
    bomb = Bomb.instance
    session[:bomb] = bomb
    if bomb.booted?
      erb :reset_codes
    else
      erb :boot_bomb
    end
  end

  post '/reset_codes' do
    bomb = Bomb.instance
    bomb.configure_arming_code(params[:arming_code_reset])
    bomb.configure_disarming_code(params[:disarming_code_reset])
    session[:bomb] = bomb
    erb :villain
  end

  get '/disarm_bomb' do
    load_session
    erb :disarm_bomb
  end

  post '/disarm_bomb' do
    bomb = Bomb.instance
    session[:bomb] = bomb
    bomb.disarm(params[:disarming_code])
    if bomb.disarmed? || bomb.detonated?
      erb :outcome
    else
      erb :disarm_bomb
    end
  end

  get '/arm_bomb' do
    bomb = Bomb.instance
    session[:bomb] = bomb
    erb :arm_bomb
  end

  post '/arm_bomb' do
    bomb = Bomb.instance
    bomb.arm(params[:arming_code])
    session[:bomb] = bomb
    erb :villain
  end

  get '/outcome' do
    load_session
    erb :outcome
  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end
