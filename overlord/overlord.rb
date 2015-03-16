# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require './bomb'

enable :sessions

get '/' do
  haml :index
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
