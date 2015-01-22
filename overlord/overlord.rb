# run `ruby overlord.rb` to run a webserver for this app

require_relative 'bomb'
require 'sinatra'

enable :sessions

get '/' do 
	haml :index
  # "Time to build an app around here. Start time: " + start_time
end

get '/test' do
  haml :test, locals: { keys: session.keys }
end

get '/form' do
	haml :form
end

post '/form' do
	@bomb = Bomb.new(params[:activation_code], params[:deactivation_code])
	haml :form_post, locals: { bomb: @bomb }
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
