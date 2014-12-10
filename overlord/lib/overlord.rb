require 'sinatra/base'
enable :sessions

class Overlord < Sinatra::Base

  get '/' do
    "Time to build an app around here. Start time: " + start_time
  end

  # we can shove stuff into the session cookie YAY!
  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
