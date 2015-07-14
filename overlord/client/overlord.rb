# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'pry'
require 'haml'

get '/' do
  haml :index
end
