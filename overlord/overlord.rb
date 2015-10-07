# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require './lib/bomb'

enable :sessions

bomb = Bomb.new("1234", "0000", "bad code")

get '/' do

	@bombStatus = bomb.active? ? "live" : "inactive"
	@tries = bomb.failed_deactivations
	@maxTries = bomb.max_failed_deactivations
	erb :index
  # "Time to build an app around here. Start time: " + start_time
end

post '/' do
	code = params['code']

	bomb.enter_code(code)
	@bombStatus = bomb.active? ? "live" : "inactive"

	if bomb.active?

	end
	erb :index
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
