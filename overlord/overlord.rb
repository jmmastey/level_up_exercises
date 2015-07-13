# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'coffee-script'

enable :sessions

set :port, 8080
set :static , true
set :public_folder, "static"
set :views, "views"


get '/' do
  "Time to build an app around here. Start time: " + start_time
end


get '/hello/' do
  erb :hello_form
end

post '/hello/' do
  greeting = params[:greeting] || "Hi There"
  name = params[:name] || "Nobody"

  erb :index, :locals => {'greeting' => greeting, 'name' => name}
end

# we can shove stuff into the session cookie YAY!
# def start_time
#   session[:start_time] ||= (Time.now).to_s
# end
#
# get "/coffee/*.js" do
#   filename = params[:splat].first
#   coffee "../public/coffee/#{filename}".to_sym
# end
#
# get '/application.js' do
#   coffee :application
# end

# get '/:name' do
#   "Hello, #{params[:name]}!, it is: " + start_time
# end
