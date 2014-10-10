# run `ruby overlord_spec.rb` to run a webserver for this app

require 'sinatra'
require_relative 'bomb'

enable :sessions

get '/' do
  erb :index
end

def bomb
  session[:bomb] ||= Bomb.new
end

post '/activate' do
  begin
    bomb.activate(params[:activation_code], params[:deactivation_code])
  rescue StandardError => error
    @errors = error
  end
  erb :activated
end

post '/deactivate' do
  begin
    bomb.deactivate(params[:deactivation_code])
      erb :deactivated
  rescue StandardError => error
    @errors = error
    erb :exploded
  end
end


# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
  session[:activated] ||= bomb.activated?
end
