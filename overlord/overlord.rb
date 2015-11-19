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
  redirect to('/exploded') if bomb.exploded?

  @dummy = dummy[rand(3)] if params['dummy']
  @bomb_active = bomb.active?
  @tries = bomb.failed_deactivations
  @max_tries = bomb.max_failed_deactivations

  erb :bomb
  # "Time to build an app around here. Start time: " + start_time
end

get '/exploded' do 
  redirect to('/') unless bomb.exploded?
  erb :exploded
end

post '/' do
  code = params['code']

  redirect to('/?dummy=duh') unless code =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
  bomb.enter_code(code)

  redirect to('/')
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
