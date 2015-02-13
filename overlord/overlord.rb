require './environment.rb'

class Overlord < Sinatra::Base

  register Sinatra::Flash
  helpers Sinatra::Param

  before '/*' do
    session_interface
  end

  get '/' do
    if Bombs.count > 0
      redirect to payload_state_redirect
    end
    erb :root
  end

  get '/boot_device' do
    unless valid_event?('deactivated')
      redirect to payload_state_redirect
    end
    erb :boot_device
  end

  post '/boot_device' do
    boot_code = params[:boot_code]
    if session_interface.turn_on(boot_code.to_i)
      redirect to '/create_bomb'
    else
      flash.now[:error] = "Incorrect Boot Code!"
      erb :boot_device
    end
  end

  get '/create_bomb' do
    unless valid_event?('activated')
      redirect to payload_state_redirect
    end
    erb :create_bomb
  end

  post '/create_bomb' do
    if session_interface.configure_settings(params) && session_interface.deploy
      redirect to '/disarm_bomb'
    else
      status 404
    end
  end

  get '/disarm_bomb' do
    unless valid_event?('armed')
      redirect to payload_state_redirect
    end
    erb :disarm_bomb, :locals => { :timer => session_interface.payload.timer }
  end

  post '/disarm_bomb' do
    disarming_code = params[:disarming_code]

    if session_interface.disable(disarming_code.to_i)
      redirect to payload_state_redirect
    end

    session_interface.count_disarming_attempts

    if session_interface.max_attempts_reached?
      session_interface.payload.detonate
      redirect to payload_state_redirect
    end

    erb :disarm_bomb
  end

  get '/disarmed_bomb' do
    unless valid_event?('disarmed')
      redirect to payload_state_redirect
    end
    erb :disarmed_bomb
  end

  post '/detonate_bomb' do
    # set to detonate then delete
    # redirect to show page where bomb detonated
    if session_interface.trigger_explosion
      status 200
    else
      status 500
    end
  end

  get '/detonated_bomb' do
    unless valid_event?('detonated')
      redirect to payload_state_redirect
    end
    erb :detonated_bomb
  end

  post '/destroy_bomb' do
    if valid_event?('disarmed') || valid_event?('detonated')
      session_interface.destroy_payload
      status 200
    else
      status 500
    end
  end

  run! if app_file == $0

  private

  def session_interface
    session[:interface] ||= Interface.new
  end

  def payload_state_redirect
    case session_interface.payload.state
      when 'activated'
        '/create_bomb'
      when 'armed'
        '/disarm_bomb'
      when 'detonated'
        '/detonated_bomb'
      when 'disarmed'
        '/disarmed_bomb'
      else
        '/'
    end
  end

  def valid_event?(required_event)
    session_interface.payload.state == required_event
  end
end
