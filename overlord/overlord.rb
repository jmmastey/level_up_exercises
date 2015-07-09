# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'

enable :sessions

get '/' do
  #"Time to build an app around here. Start time: " + start_time
  "Evil Bomb Controller 5.0" + "<div class=\"config\">TEST</div>"
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
