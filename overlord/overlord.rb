require 'sinatra/base'
require_relative('lib/bomb')
require_relative('lib/timer')

class Overlord < Sinatra::Application
  FIVE_MINUTES_IN_SECONDS = 5 * 60

  BOMB_ROUTE = '/bomb'
  INITIALIZE_ROUTE = '/initialize'
  BOMB_BOOT_ROUTES = [INITIALIZE_ROUTE, '/boot']

  enable :sessions

  before do
    bomb_is_unbooted = session[:bomb].nil?
    is_boot_bomb_action = BOMB_BOOT_ROUTES.include?(request.path_info)

    redirect to INITIALIZE_ROUTE if bomb_is_unbooted && !is_boot_bomb_action
    redirect to BOMB_ROUTE if !bomb_is_unbooted && is_boot_bomb_action
  end

  not_found do
    redirect to '/'
  end

  helpers do
    def validate_codes(params)
      errors = {}
      errors[:activation_code] = 'Activation Code must be a 4-digit number' unless validate_code(params['activation_code'])
      errors[:deactivation_code] = 'Deactivation Code must be a 4-digit number' unless validate_code(params['deactivation_code'])
      errors
    end

    def validate_code(code)
      code =~ /\A\d+\Z/
    end

    def set_timer_on_bomb
      if session[:bomb].active?
        session[:bomb].timer ||= Timer.new(FIVE_MINUTES_IN_SECONDS)
      else
        session[:bomb].timer = nil
      end
    end
  end

  get '/' do
    redirect to BOMB_ROUTE
  end

  get INITIALIZE_ROUTE do
    erb :initialize, locals: { errors: {} }
  end

  post '/boot' do
    errors = validate_codes(params)

    if errors.any?
      erb :initialize, locals: { errors: errors }
    else
      session[:bomb] = Bomb.new(params['activation_code'], params['deactivation_code'])
      redirect to BOMB_ROUTE
    end
  end

  get '/bomb' do
    erb :bomb, locals: { bomb: session[:bomb] }
  end

  post '/enter-code' do
    session[:bomb].enter_code(params['code'])
    set_timer_on_bomb
    redirect to BOMB_ROUTE
  end

  run! if __FILE__ == $0
end
