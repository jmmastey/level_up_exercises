require 'sinatra/base'
require 'facets'
require_relative 'super_villain_tools'

class Overlord < Sinatra::Base
  enable :sessions
  set :public_folder, proc { File.join(File.dirname(__FILE__), 'public') }

  before do
    session[:tools] ||= SuperVillainTools.new
    @tools = session[:tools]
    params.map { |key, _| key.to_sym }
  end

  get '/' do
    File.read(File.join('public', 'index.html'))
  end

  get '/bomb_status' do
    return "No Bomb" unless @tools.bomb?
    @tools.bomb.status.to_s.capitalize + " Bomb"
  end

  post '/create_bomb' do
    options = params["options"].nil? ? {} : params["options"].symbolize_keys
    begin
      @tools.create_bomb(options: options)
      message = @tools.bomb? ? "Bomb is created" : "Bomb not created"
    rescue StandardError => e
      message = e.to_s
    end
    message
  end

  post '/activate_bomb' do
    puts "params: " + params.inspect
    @tools.bomb.activate(params[:activation_code])
    @tools.bomb.active? ? "Bomb Activated" : "Wrong Code"
  end

  post '/deactivate_bomb' do
    @tools.bomb.deactivate(params[:deactivation_code])
    message = @tools.bomb.active? ? "Wrong Code" : "Bomb deactivated"
    message = "Wrong Code, Bomb detonated" if @tools.bomb.detonated?
    message
  end
  # we can shove stuff into the session cookie YAY!
  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  run! if app_file == $PROGRAM_NAME
end
