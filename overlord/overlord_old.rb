require 'sinatra/base'
require 'rack-flash'

class Overlord < Sinatra::Application

  enable :sessions
  set :pseudo_in_memory_store, Hash.new({})
  use Rack::Flash

  Tilt.register Tilt::ERBTemplate, 'html.erb'

  get '/' do
    server_side_session = get_in_memory_session
    redirect to("/activated") if server_side_session[:bomb_status] == "armed"
    erb :bomb_activation 
  end

  post '/activate' do
    server_side_session = get_in_memory_session
    if validate_code(params[:activation_code]) || server_side_session[:bomb_status].eql?("armed")
      server_side_session[:bomb_status] = "armed"
      server_side_session[:armed_at] = Time.now
      server_side_session[:retries] = 3
      redirect to("/activated")
    end
    redirect back
  end

  get '/activated' do
    server_side_session = get_in_memory_session
    redirect to("/") unless server_side_session[:bomb_status].eql?("armed")
    if (15 - (Time.now - server_side_session[:armed_at]) < 0)
      redirect to("/boom")
    end
    erb :armed_countdown, locals: {armed_at: server_side_session[:armed_at]}
  end

  post '/deactivate' do
    server_side_session = get_in_memory_session
    if validate_code(params[:deactivation_code])
      flash[:notice] = "Bomb successfully deactivated"
      server_side_session[:bomb_status] = nil
      redirect to("/")
    else
      server_side_session[:retries] -= 1
      if server_side_session[:retries].zero?
        redirect to("/boom")
      end
      flash[:notice] = "Nope, nope, nope, nope, nope. You have #{server_side_session[:retries]} tries left."
      redirect to('/activated')
    end
  end

  get '/boom' do
    server_side_session = get_in_memory_session
    redirect to('/') if server_side_session[:bomb_status].nil?
    if server_side_session[:bomb_status].eql? "armed"
      if (15 - (Time.now - server_side_session[:armed_at]) < 0)
        server_side_session[:bomb_status] = "exploded"
      else
        redirect to('/activated')
      end
    end
    server_side_session[:bomb_status] = nil
    erb :blown
  end

  def validate_code(code)
    code =~ /\d{4}/
  end

  def get_in_memory_session
    settings.pseudo_in_memory_store[session[:session_id]]
  end

end
