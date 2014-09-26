# run `ruby pmail.rb` to run a webserver for this app

require 'sinatra'

get '/' do
  haml :index
end
