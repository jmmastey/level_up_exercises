require 'sinatra/base'

class Overlord < Sinatra::Application
  STATUS_TAMPLATES = {
    new: :boot,
    booted: :booted,
    active: :active,
    exploded: :boom,
  }
  STATUS_TEXT = {
    new: "Not Ready",
    booted: "Booted Up",
    active: "Activated",
    exploded: "Exploded",
  }

  enable :sessions
  # Enable put and delete verbs from forms using hidden input
  set :method_override, true

  get '/' do
    render_status
  end

  post '/' do
    return [400, "Bomb already booted"] if bomb_status != :new
    if set_valid_boot_codes
      session[:status] = :booted
      render_status
    else
      [400, "Invalid codes entered"]
    end
  end

  # Activate
  put '/' do
    return [400, "Bomb cannot be activated now"] if bomb_status != :booted
    session[:status] = :active if params[:code] == session[:activation_code]
    render_status
  end

  # Deactivate
  delete '/' do
    return [400, "Bomb connot be deactivated now"] if bomb_status != :active
    if params[:code] == session[:deactivation_code]
      session.clear
    else
      session[:deactivation_tries] = session[:deactivation_tries].to_i + 1
      session[:status] = :exploded if session[:deactivation_tries] == 3
    end
    render_status
  end

  # Hidden override
  get '/reset' do
    session.clear
    redirect '/'
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME

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

  def render_status
    erb STATUS_TAMPLATES[bomb_status], :locals => { status_desc: STATUS_TEXT[bomb_status] }
  end
end
