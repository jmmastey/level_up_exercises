# run `ruby overlord.rb` to run a webserver for this app
require "rubygems"
require "sinatra"
require "erb"
require "shotgun"
require_relative "bomb"

enable :sessions
set :port, 9393
set :bind, "0.0.0.0"

get "/" do
  session[:bomb] = Bomb.new
  @bomb = session[:bomb]
  erb :inactive
end

post "/activate" do
  code = params[:activation_code]
  if valid_code?(code)
    bomb = session[:bomb]
    bomb.enter_code(code.to_i)
    bomb.activate
     @bomb = session[:bomb]
    if bomb.active?
      erb :activated
    else
      erb :inactive
    end
  else
    @bomb = session[:bomb]
    erb :inactive
  end
end

post "/deactivate" do
  code = params[:deactivation_code]
  if valid_code?(code)
  bomb = session[:bomb]
  bomb.enter_code(code.to_i)
  bomb.deactivate
     @bomb = session[:bomb]
     if bomb.exploded?
        erb :exploded
     else
        erb :activated
     end
  else
    @bomb = session[:bomb]
    erb :inactive
  end
  end


  # @bomb = session[:bomb] 
  # :activated if code 'attempt' is incorrect but not past limit
  # :inactive if code 'attempt' is correct
  # :exploded if code 'attempt' is incorrect and past limit

def valid_code?(code)
  /\A[0-9]{4}\Z/.match(code)
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end
