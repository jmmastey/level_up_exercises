# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require_relative "bomb"

enable :sessions

get '/' do
  erb :index
end

post '/set-codes' do
  @bomb = Bomb.new(activation_code: params[:activation_code],
                   deactivation_code: params[:deactivation_code])
  erb :toggle_bomb
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
