# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'

require_relative './lib/overlord'

enable :sessions
enable :logging

get '/' do
  @bomb = Overlord::Bomb.new

  erb :index
end

post '/' do
  @bomb = Overlord::Bomb.new
  @bomb.process_code(params[:code])

  erb :index
end

# we can shove stuff into the session cookie YAY!
# def start_time
#   session[:start_time] ||= (Time.now).to_s
# end
