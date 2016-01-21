# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'

$LOAD_PATH << 'lib'

require 'bomb'

enable :sessions

get '/' do
  code = params[:code]

  bomb.enter_code(code) if code

  erb :index, locals: {
    bomb: bomb
  }
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end

def bomb
  session[:a_bomb] ||= Bomb.new
end