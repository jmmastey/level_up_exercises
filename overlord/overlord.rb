# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require_relative 'lib/bomb'

enable :sessions
set :session_secret, "rdc_overlord"

ACTIVATION_DEFAULT = "1234"
DEACTIVATION_DEFAULT = "0000"

get '/' do
  erb :set_activation
end

post '/set_activation' do
  use_default_code(:activation) if need_to_use_default_code?
  if code_bad_format?
    params[:bad_format] = true
    erb :set_activation
  else
    assign_code(:activation)
    erb :set_deactivation
  end
end

post '/set_deactivation' do
  params[:idiot] = code_duplicate?
  use_default_code(:deactivation) if need_to_use_default_code?
  if code_bad_format?
    params[:bad_format] = true
    erb :set_deactivation
  else
    assign_code(:deactivation)
    create_bomb
    erb :control_panel
  end
end

post '/control_panel' do
  if session[:bomb].status == :inactive
    erb :confirm_activation
  else
    session[:bomb].enter_code(params[:code])
    if session[:bomb].status == :exploded
      erb :rubble
    else
      erb :control_panel
    end
  end
end

post '/confirm_activation' do
  session[:bomb].enter_code(params[:code])
  params[:loser] = session[:bomb].status == :inactive
  erb :control_panel
end

post '/cut' do
  session[:bomb].cut_wires!
  erb :damaged
end

helpers do
  def use_default_code(type)
    params[:code] = ACTIVATION_DEFAULT if type == :activation
    params[:code] = DEACTIVATION_DEFAULT if type == :deactivation
  end

  def need_to_use_default_code?
    code_empty? || code_duplicate?
  end

  def code_empty?
    params[:code] == ""
  end

  def code_duplicate?
    params[:code] == session[:act_code]
  end

  def code_bad_format?
    !code_empty? && !(params[:code] =~ /^\d\d\d\d$/)
  end

  def assign_code(type, value: params[:code])
    session[:done_asking] = false
    session[:act_code] = value if type == :activation
    session[:deact_code] = value if type == :deactivation
  end

  def create_bomb
    session[:bomb] = Bomb.new(session[:act_code], session[:deact_code])
  end
end
