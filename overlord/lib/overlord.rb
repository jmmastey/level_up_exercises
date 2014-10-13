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
    session[:attempts] = 0

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

  get '/explosion' do
    erb :explosion
  end

  def num?(number)
    /^[\d]{1,9}$/ =~ number
  end

  def check_activate_code(code)
    return unless session[:activate_code] == code

    session[:bomb_state] = 'activated'
    session[:attempts] = 0
  end

  def check_deactivate_code(code)
    if session[:deactivate_code] == code
      session[:bomb_state] = 'not activated'
      session[:attempts] = 0
    else
      session[:attempts] += 1
    end
  end

  def check_for_explosion
    return if session[:attempts] < 3

    session[:bomb_state] = 'exploded'
    redirect '/explosion'
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
