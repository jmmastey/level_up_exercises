require 'sinatra'

enable :sessions

get '/' do
  haml :index
end

post '/boot' do
  haml :booted
end

post '/activate' do
  haml :activated
end

post '/exploded' do
  haml :exploded
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
