require 'sinatra/base'

class Overlord < Sinatra::Base
  enable :sessions

  get '/' do
    # @state = 'bomb is not activated'
    session[:bomb_state] ||= 'bomb is not activated'
    erb :home
  end

  post '/activated' do
    # @state = 'bomb is activated'
    session[:bomb_state] = 'POST bomb is activated'
    redirect '/'
  end

  post '/detonated' do
    # @state = 'bomb has blown up'
    session[:bomb_state] = 'bomb has blown up'
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
