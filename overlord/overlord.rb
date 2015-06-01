require 'sinatra/base'
require 'facets'
class Overlord < Sinatra::Base

  enable :sessions

  before do
    session[:tools] ||= SuperVillainTools.new
    @tools = session[:tools]
    params.map { |key,_| key.to_sym }
  end

  get '/' do
    return "No Bomb" unless @tools.has_bomb?
    @tools.bomb.status.to_s + " Bomb"
  end

  post '/create_bomb' do
    options = params["options"].nil? ? {} : params["options"].symbolize_keys
    begin
      @tools.create_bomb(options: options)
      message = @tools.has_bomb? ? "Bomb is created" : "Bomb not created"
    rescue Exception => e
      message = e.to_s
    end
    message
  end

  post '/activate_bomb' do
    @tools.bomb.activate(params[:code])
    @tools.bomb.active? ? "Bomb Activated" : "Wrong Code"
  end

  post '/deactivate_bomb' do
    @tools.bomb.deactivate(params[:code])
    message = @tools.bomb.active? ? "Wrong Code" : "Bomb deactivated"
    message = "Wrong Code, Bomb detonated" if @tools.bomb.detonated?
    message
  end
  # we can shove stuff into the session cookie YAY!
  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
