# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require './bomb'

enable :sessions

get '/' do
  bomb = Bomb.new
  puts bomb
  session[:bomb_status] = bomb.status
  erb :home
end

# we can shove stuff into the session cookie YAY!
def start_time

end
