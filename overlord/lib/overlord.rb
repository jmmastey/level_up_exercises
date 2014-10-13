require 'sinatra/base'

class Overlord < Sinatra::Base
  enable :sessions

  get '/' do
    update_bomb_state 'not booted'
    erb :home
  end

  post '/boot' do
    update_bomb_state 'not activated'

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
      if session[:activate_code] == params[:code]
        session[:attempts] = 0
      elsif session[:deactivate_code] == params[:code]
        update_bomb_state 'not activated'
      else
        session[:attempts] += 1
        # update_bomb_state 'activated'
      end
    else
      update_bomb_state 'activated'
    end

    redirect '/bomb'
  end

  def update_bomb_state(state)
    session[:bomb_state] = state
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
