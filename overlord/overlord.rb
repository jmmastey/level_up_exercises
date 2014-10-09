# run `ruby overlord_spec.rb` to run a webserver for this app

require 'sinatra'

enable :sessions

configure do
  set :activated, false
  set :activation_code, 0000
  set :deactivation_code, 0000
end

get '/' do
  erb :index
end

post '/activate' do
  if (params[:activation_code] == params[:deactivation_code])
    redirect "/"
  end
  @activated = true
  erb :activated
end


# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
  session[:activated] ||= @activated
end
