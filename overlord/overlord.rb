# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'capybara/rspec'

enable :sessions

get '/' do
  erb :index
end

get '/bomb' do

  erb :bomb
  #"Time to build an app around here. Start time: " + start_time
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end

#@start_time = start_time
