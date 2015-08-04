# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'haml'
require 'sass'
require 'pp'

enable :sessions

get '/' do
	haml :index
end

post '/' do
	if params[:code].nil? 
		code = 1234
	else
		code = params[:code]
	end
	haml :index
end

# we can shove stuff into the session cookie YAY!
def start_time
	session[:start_time] ||= (Time.now).to_s
end
