# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'

enable :sessions

get '/' do
  erb :index, :layout => :layout_no_header
end

get '/start' do
  erb :start
end

post '/activate' do
  # activate the bomb
  erb :activated
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
