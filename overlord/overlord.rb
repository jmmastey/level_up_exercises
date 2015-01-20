# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'

require_relative './lib/overlord'

enable :sessions
enable :logging

before do
  @bomb = Overlord::Bomb.new(session[:bomb])
  session[:message] = ''

  if @bomb.exploded?
    session[:message] = 'Oops! The bomb has exploded!'
    erb :index
  end
end

get '/' do
  erb :index
end

post '/' do
  @bomb.process_code(params[:code])

  if @bomb.exploded?
    session[:message] = 'Oops! The bomb has exploded!'

    # TODO: confirm necessity of `return` here
    return erb :index
  end

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
