# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require_relative 'bomb'

enable :sessions

get '/' do
  "Time to build an app around here. The bomb is currently: " + bomb.status
end

# we can shove stuff into the session cookie YAY!
# it's not actually a great practice to put objects into the
# session, but it will do here.
def bomb
  session[:bomb] ||= Bomb.new
end
