# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
class MyOverlord < Sinatra::Base

enable :sessions

get '/' do
  "Time to build an app around here. Countdown! Start time: " + start_time
  #return erb :vilian_page unless @bomb_ready
  #return erb :start_page
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end

end
