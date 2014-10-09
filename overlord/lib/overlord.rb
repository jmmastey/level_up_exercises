require 'sinatra/base'

class Overlord < Sinatra::Base
  enable :sessions

  get '/' do
    @state = 'bomb is not activated'
    erb :home
  end

  get '/activated' do
    @state = 'bomb is activated'
  end

  get '/detonated' do
    @state = 'bomb has blown up'
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
