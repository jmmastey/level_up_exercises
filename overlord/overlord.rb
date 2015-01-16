# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'

require_relative './lib/overlord'

enable :sessions
enable :logging

get '/' do
  @bomb = Overlord::Bomb.new(session[:bomb])

  erb :index
end

post '/' do
  @bomb = Overlord::Bomb.new(session[:bomb])
  @bomb.process_code(params[:code])
  session[:bomb] = @bomb.initialize_session

  erb :index
end
