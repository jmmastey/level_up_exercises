require 'sinatra/base'

class Overlord < Sinatra::Base
  enable :sessions

  get '/' do
    @state = 'bomb is not activated'
    # 'Hello Overlord!' \
    # '<input type="button" id ="arm-button" name="arm-button" value="Arm the bomb">'
    erb :home
  end

  get '/activated' do
    'The bomb is activated'
  end

  get '/detonated' do
    'The bomb has blown up'
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
