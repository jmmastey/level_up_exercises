# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require_relative 'lib/bomb'

enable :sessions
# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'

enable :sessions

get '/' do
  "Time to build an app around here. Start time: " + start_time
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
