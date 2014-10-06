require 'sinatra/base'

class Overlord < Sinatra::Base
  enable :sessions
  STATUS_TAMPLATES = {
    new: :boot,
    booted: :booted,
    active: :active,
    exploded: :boom,
  }

  get '/' do
    erb STATUS_TAMPLATES[bomb_status]
  end

  post '/boot' do
    return [400, "Bomb already booted"] if bomb_status != :new
    session[:activation_code] = valid_or_default_code(params[:activation_code], "1234")
    session[:deactivation_code] = valid_or_default_code(params[:deactivation_code], "0000")
    if session[:activation_code] && session[:deactivation_code]
      session[:status] = :booted
      redirect '/'
    else
      status 400
      body "Invalid codes entered"
    end
  end

  post '/activate' do
    session[:status] = :active if params[:code] == session[:activation_code]
    redirect '/'
  end

  post '/deactivate' do
    if params[:code] == session[:deactivation_code]
      session[:status] = :new
    else
      session[:deactivation_tries] = session[:deactivation_tries].to_i + 1
      session[:status] = :exploded if session[:deactivation_tries] == 3
    end
    redirect '/'
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME

  private

  def valid_or_default_code(code, default)
    return default if code.empty?
    return code if valid_code(code)
  end

  def valid_code(code)
    code =~ /^\d{4}$/
  end

  def bomb_status
    session[:status] || :new
  end
end
