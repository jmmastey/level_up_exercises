# run `ruby overlord.rb` to run a webserver for this app

require "pry"
require "sinatra/base"
require "sinatra"

enable :sessions

class Overload < Sinatra::Application
  get '/' do
    "Time to build an app around here. Start time: " + start_time
  end

  # we can shove stuff into the session cookie YAY!
  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  run! if app_file == $0
end
