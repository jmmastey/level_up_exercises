# run `ruby overlord_spec.rb` to run a webserver for this app

require 'sinatra'

enable :sessions

configure do
  set :activated, false
end

get '/' do
  "Time to build an app around here. Start time: " + start_time
end

get '/ip' do
  settings.activated?
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
