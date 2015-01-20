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
  session[:message] = ''

  @bomb.process_code(params[:code])
  session[:bomb] = @bomb.initialize_session

  erb :index
end

post '/activation_code' do
  @bomb = Overlord::Bomb.new(session[:bomb])
  session[:message] = ''

  if @bomb.update_activation_code(params[:activation_code])
    session[:message] = "Activation code updated."
  else
    session[:message] = "Error: Activation code can only contain digits."
  end

  session[:bomb] = @bomb.initialize_session

  erb :index
end

post '/deactivation_code' do
  @bomb = Overlord::Bomb.new(session[:bomb])
  session[:message] = ''

  if @bomb.update_deactivation_code(params[:deactivation_code])
    session[:message] = "Deactivation code updated"
  else
    session[:message] = "Error: Deactivation code can only contain digits."
  end

  session[:bomb] = @bomb.initialize_session

  erb :index
end
