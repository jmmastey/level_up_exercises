require 'sinatra/base'

class BombError < Exception; end
class BombExploaded < Exception; end

class Overlord < Sinatra::Application
  STATUS_TAMPLATES = {
    new: :boot,
    booted: :booted,
    active: :active,
  }

  STATUS_TEXT = {
    new: "Not Ready",
    booted: "Booted Up",
    active: "Activated",
  }

  enable :sessions
  # Enable put and delete verbs from forms using hidden input
  set :method_override, true

  get '/' do
    render_bomb_page
  end

  #Boot
  post '/' do
    raise(BombError, "Bomb already booted") if bomb_status != :new
    raise(BombError, "Invalid codes entered") unless set_valid_boot_codes
    session[:status] = :booted
    render_bomb_page
  end

  # Activate
  put '/' do
    raise(BombError, "Bomb cannot be activated now") if bomb_status != :booted
    if params[:code] == session[:activation_code]
      session[:status] = :active
      session[:expire] = Time.now + (params[:time] || 30).to_i
    end
    render_bomb_page
  end

  # Deactivate
  delete '/' do
    check_exploaded
    raise(BombError, "Bomb connot be deactivated now") if bomb_status != :active
    if params[:code] == session[:deactivation_code]
      session.clear
    else
      session[:deactivation_tries] = session[:deactivation_tries].to_i + 1
      session[:status] = :exploded if session[:deactivation_tries] == 3
    end
    render_bomb_page
  end

  # Hidden override
  get '/reset' do
    session.clear
    redirect url('/')
  end

  error BombError do
    status 400
    erb :error, :locals => { 
      status_desc: "Not Happy",
      error_message: env['sinatra.error'].message,
    }
  end

  error BombExploaded do
    erb :boom, :locals => { status_desc: "Exploaded" }
  end

  private 

  def set_valid_boot_codes
    session[:activation_code] = code_if_valid(params[:activation_code], "1234")
    session[:deactivation_code] = code_if_valid(params[:deactivation_code], "0000")
    session[:activation_code] && session[:deactivation_code]
  end

  def code_if_valid(code, default = nil)
    return default if code.empty?
    return code if valid_code?(code)
  end

  def valid_code?(code)
    code =~ /^\d{4}$/
  end

  def bomb_status
    session[:status] || :new
  end

  def render_bomb_page
    check_exploaded
    erb STATUS_TAMPLATES[bomb_status], 
      :locals => { status_desc: STATUS_TEXT[bomb_status] }
  end

  def check_exploaded
    if session[:status] == :active && Time.now > session[:expire]
      session[:status] = :exploded
    end
    raise(BombExploaded) if session[:status] == :exploded
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end
