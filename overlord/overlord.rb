# run `ruby overlord.rb` to run a webserver for this app

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
	haml :form_post, locals: { :message => params[:message] }
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
