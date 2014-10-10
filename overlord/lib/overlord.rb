require 'sinatra/base'

class Overlord < Sinatra::Base
  enable :sessions

  get '/' do
    session[:bomb_state] ||= 'not booted'
    session[:attempts] = 0
    erb :home
  end

  get '/inactive' do
    # session[:bomb_state] = 'inactive'
    erb :bomb
  end

  get '/active' do
    # session[:bomb_state] = 'active'
    erb :bomb
  end

  get '/explode' do
    # session[:bomb_state] = 'blown up'
    erb :explode
  end

  post '/booted' do
    session[:bomb_state] = 'inactive'
    session[:activate_code] ||= 1234
    session[:deactivate_code] ||= 0000
    redirect '/inactive'
  end

  post '/activated' do
    redirect '/inactive' unless params[:code] == session[:activate_code]

    session[:bomb_state] = 'active'
    redirect '/active'
  end

  post '/inactivated' do
    if params[:code] == session[:deactivate_code] && session[:attempts] < 2
      session[:bomb_state] = 'inactive'
      redirect '/inactive'
    else
      redirect '/detonated', 303
    end
  end

  post '/detonated' do
    # @state = 'bomb has blown up'
    session[:bomb_state] = 'blown up'
    redirect '/explode'
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
