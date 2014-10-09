require 'sinatra/base'

class Overlord < Sinatra::Base
  enable :sessions

  get '/' do
    'Hello Overlord!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
