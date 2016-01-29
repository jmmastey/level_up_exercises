# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'

$LOAD_PATH << 'lib'
require 'bomb'

enable :sessions

get '/' do
  code = params[:code]
  response = bomb.enter_code(code) if code

  p response # for logging params

  erb :index, locals: { bomb: bomb }
end

def bomb
  session[:bomb] ||= Bomb.new("1234", "0000")
end
