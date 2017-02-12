require 'sinatra/base'

class Overlord < Sinatra::Base
  enable :sessions

  get '/' do
    session[:bomb_state] = 'not booted'
    erb :home
  end

  post '/boot' do
    unless num?(params[:activation_code]) && num?(params[:deactivation_code])
      redirect '/'
    end

    session[:bomb_state] = 'not activated'
    session[:activate_code] = params[:activation_code]
    session[:deactivate_code] = params[:deactivation_code]
    reset_attempts

    redirect '/bomb'
  end

  get '/bomb' do
    erb :bomb
  end

  post '/switch' do
    if session[:bomb_state] == 'activated'
      check_deactivate_code(params[:code])
    else
      check_activate_code(params[:code])
    end

    check_for_explosion

    redirect '/bomb'
  end

  helpers do
    def num?(number)
      /^[\d]{1,9}$/ =~ number
    end

    def check_activate_code(code)
      return unless session[:activate_code] == code

      session[:bomb_state] = 'activated'
      reset_attempts
    end

    def check_deactivate_code(code)
      if session[:deactivate_code] == code
        session[:bomb_state] = 'not activated'
        reset_attempts
      else
        session[:attempts] += 1
      end
    end

    def check_for_explosion
      return if session[:attempts] < 3

      session[:bomb_state] = 'exploded'
    end

    def reset_attempts
      session[:attempts] = 0
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end
