# run `ruby overlord.rb` to run a webserver for this app

require_relative 'bomb'
require 'sinatra'

enable :sessions

get '/' do
	session.clear
	redirect to('/boot_bomb')
end

post '/activate' do
	session[:bomb].try_to_activate(params[:submitted_act_code])
	if session[:bomb].state == false
		session[:bad_act_code] = true
		redirect to('activate')
	end
	haml :activated_bomb, locals: { bomb: session[:bomb] }
end

get '/activate' do
  haml :booted_bomb, locals: { bomb: session[:bomb], bad_code: session[:bad_act_code] }
end

post '/deactivate' do
	if session[:bomb].attempts_remaining > 0
		session[:bomb].try_to_deactivate(params[:submitted_deac_code])
	end
	haml :active_bomb, locals: { bomb: session[:bomb] }
end

get '/boot_bomb' do
	haml :enter_codes
end

post '/boot_bomb' do
	session[:bomb] = Bomb.new(params[:act_code], params[:deact_code])
	"#{params.keys} #{params.values} #{session[:bomb].activation_code}"
	# redirect to('/activate')
end
