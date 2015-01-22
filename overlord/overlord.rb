# run `ruby overlord.rb` to run a webserver for this app

require_relative 'bomb'
require 'sinatra'

enable :sessions

get '/' do
	session.clear
	redirect to('/boot_bomb')
end

post '/activate' do
	session[:bomb].try_to_activate(params[:submitted_activation_code])

	haml :activated_bomb, locals: { bomb: session[:bomb] }
end

get '/activate' do
  "ABBB"
end

post '/deactivate' do
	# redirect back if
	session[:bomb].try_to_deactivate(params[:submitted_deactivation_code])
	haml :active_bomb, locals: { bomb: session[:bomb] }
end

get '/boot_bomb' do
	haml :enter_codes
end

post '/boot_bomb' do
	session[:bomb] = Bomb.new(params[:activation_code], params[:deactivation_code])
	haml :boot_bomb, locals: { bomb: session[:bomb] }
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
