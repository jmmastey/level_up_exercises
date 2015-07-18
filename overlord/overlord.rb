# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'json'

class Overlord < Sinatra::Base
  enable :sessions

  set :public_folder, File.dirname(__FILE__) + '/public'

  get '/' do
    session.delete(:bomb)
    erb :home,
        layout: 'layouts/main'.to_sym,
        locals: { bomb: session[:bomb] }
  end

  get '/bomb' do
    content_type :json
    bomb_count = session[:bomb].nil? ? 0 : 1
    { count: bomb_count }.to_json
  end

  delete '/bomb/delete' do
    session.delete(:bomb)
  end
end
