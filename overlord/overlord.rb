# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'json'

class Overlord < Sinatra::Base
  enable :sessions

  get '/' do
    session.delete(:bomb)
    erb :home, layout: 'layouts/main'.to_sym
  end

  get '/bomb' do
    content_type :json
    bomb_count = session[:bomb].nil? ? 0 : 1
    { count: bomb_count }.to_json
  end
end
