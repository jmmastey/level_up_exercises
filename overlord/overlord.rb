# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'

require_relative './lib/overlord'

enable :sessions
enable :logging

before do
  @bomb = Overlord::Bomb.new(session[:bomb])
  session[:message] = ''
end

get '/' do
  erb :index
end

post '/' do
  @bomb.process_code(params[:code])
  session[:bomb] = @bomb.initialize_session

  erb :index
end

post '/activation_code' do
  if @bomb.update_activation_code(params[:activation_code])
    session[:message] = "Activation code updated."
  else
    session[:message] = "Error: Activation code can only contain digits."
  end

  session[:bomb] = @bomb.initialize_session

  erb :index
end

post '/deactivation_code' do
  if @bomb.update_deactivation_code(params[:deactivation_code])
    session[:message] = "Deactivation code updated"
  else
    session[:message] = "Error: Deactivation code can only contain digits."
  end

  session[:bomb] = @bomb.initialize_session

  erb :index
end
