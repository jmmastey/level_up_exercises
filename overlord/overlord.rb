# run `ruby overlord.rb` to run a webserver for this app
require "rubygems"
require "sinatra"
require "erb"
require "shotgun"
require_relative "bomb"

def bomb
  session[:bomb] ||= Bomb.new 
end

enable :sessions
set :port, 9393
set :bind, "0.0.0.0"

get "/" do
  @bomb = bomb
  erb :inactive
end

post "/activate" do
  code = params[:activation_code]
  if valid_code?(code)
    bomb = bomb
    bomb.enter_code(code.to_i)
    bomb.activate
     @bomb = session[:bomb]
    if bomb.active?
      erb :activated
    else
      erb :inactive
    end
  else
    @bomb = bomb
    erb :inactive
  end
end

post "/deactivate" do
  code = params[:deactivation_code]
  if valid_code?(code)
  bomb = bomb
  bomb.enter_code(code.to_i)
  bomb.deactivate
     @bomb = session[:bomb]
     if bomb.exploded?
        erb :exploded
     elsif !bomb.active
        erb :inactive
      else
        erb :activated
     end
  else
    @bomb = bomb
    erb :activated
  end
  end

def valid_code?(code)
  /\A[0-9]{4}\Z/.match(code)
end