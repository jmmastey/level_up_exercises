require 'sinatra'
require 'haml'
require 'json'
# require 'run_later'

class Overlord < Sinatra::Base
  configure do
    enable :sessions
    set :views, "#{File.dirname(__FILE__)}/views"
    set :public_dir, "#{File.dirname(__FILE__)}/public"
    set :session_secret, "http://open.spotify.com/track/1hR0fIFK2qRG3f3RF70pb7"
  end

  before do
    session[:bomb_state] ||= 'inactive'
    session[:countdown_active] ||= false
    session[:codes] ||= {
      :activation => ['1234'],
      :deactivation => ['0000'],
    }

    # if the zero hour has past, set bomb_state to 'detonated'
    begin
      if session[:detonation][:zero_hour] < Time.now
        session[:bomb_state] = 'detonated'
        session[:countdown_active] = false
        session[:detonation] = nil
      else
        session[:countdown_active] = true
      end
    rescue => e
      #
    end
  end

  # www methods

  get '/' do
    haml :index
  end

  get '/new' do
    session.clear
    redirect '/'
  end

  # api methods

  before '/api/*' do
    content_type :json
  end

  get '/api/state' do
    do_json({
      :bomb_state => session[:bomb_state],
      :detonation => session[:detonation],
    })
  end

  get '/api/zero_hour' do
    do_json(:zero_hour => session[:detonation][:zero_hour])
  end

  post '/api/custom_code' do
    register_for = params[:register_for]
    code = params[:code]

    if register_for != 'activation' && register_for != 'deactivation'
      do_json(:error => 'Cannot set code for method "' + register_for + '"')
    elsif session[:codes][register_for.to_sym].include?(code)
      do_json(:error => 'That registration code already exists')
    else
      session[:codes][register_for.to_sym] << code
      do_json(:success => true)
    end
  end

  post '/api/state' do
    state = session[:bomb_state]
    code = params[:pass]
    state = params[:state]

    session[:bomb_state] = 'active' if session[:codes][:activation].include?(code)
    if session[:codes][:deactivation].include?(code)
      session[:bomb_state] = 'inactive'
      session.delete(:detonation)
    end
    do_json(:bomb_state => session[:bomb_state])
  end

  post '/api/detonate' do
    now = Time.now
    wait_seconds = params[:wait].to_i
    session[:detonation] = {
      :zero_hour => now + wait_seconds,
      :countdown_start => now
    }

    do_json(session[:detonation])
  end

  private

  def do_json(data)
    data.to_json
  end
end
