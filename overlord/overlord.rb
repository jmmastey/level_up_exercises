# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require './lib/bomb'

enable :sessions

bomb = Bomb.new("1234", "0000", 3)

dummy = ["We said number dummy!",
		"Next time, I'm blowing up!",
		"Are you drunk?",
		"How could 0 to 9 confuse you?",
		"I'm going to start counting these as tries..."]

get '/' do

	if bomb.exploded?
		redirect to('/exploded')
	end

	@dummy = nil
	if params['dummy']
		index = rand(3)
		@dummy = dummy[index]
	end

	@bombActive = bomb.active?
	@tries = bomb.failed_deactivations
	@maxTries = bomb.max_failed_deactivations
	erb :index
  # "Time to build an app around here. Start time: " + start_time
end

post '/' do
	code = params['code']

	if !(code =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/)
		redirect to ('/?dummy=duh')
	end
	bomb.enter_code(code)

	redirect to('/')
end

get '/exploded' do
	erb :exploded
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
