require 'bundler/setup'
require 'sinatra'
require 'sinatra/flash'
require_relative 'lib/code'

module Overlord
  class App < Sinatra::Base
    enable :sessions
    register Sinatra::Flash

    after do
      redirect to('/') unless request.path_info == '/'
    end

    get '/' do
      session[:state] = :exploded if bomb_exploded?
      template = session[:state] || :index

      set_time_left if template == :active

      erb template
    end

    post '/start' do
      redirect_with_notice("activation")   unless validate_code(:activation_code)
      redirect_with_notice("deactivation") unless validate_code(:deactivation_code)

      session[:state] = :started
    end

    before '/activate' do
      unless params[:activation_code] == session[:activation_code]
        flash[:notice] = 'Wrong activation code'
        redirect to('/')
      end
    end

    post '/activate' do
      redirect_with_notice("countdown") unless validate_code(:countdown)

      session[:explosion_time]  ||= Time.now + session[:countdown].to_i + 1
      session[:remaining_tries] ||= 3
      session[:state]             = :active
    end

    before '/deactivate' do
      unless params[:deactivation_code] == session[:deactivation_code]
        flash[:notice] = 'Wrong deactivation code'
        session[:remaining_tries] -= 1

        session[:state] = :exploded if session[:remaining_tries] < 1
        redirect to('/')
      end
    end

    post '/deactivate' do
      session[:state] = :deactivated
    end

    get '/reset' do
      session.clear
    end

    private

    def redirect_with_notice(type)
      flash[:notice] = "Invalid #{type} code"
      redirect to('/')
    end

    def validate_code(type)
      code = Code.new(params[type], type)
      return session[type] = code.to_s unless code.to_s.nil?
      code.valid?
    end

    def bomb_exploded?
      session[:state] == :active && session[:explosion_time] - Time.now <= 0
    end

    def set_time_left
      @seconds_left = (session[:explosion_time] - Time.now).to_i
      @time_left = Time.at(@seconds_left).utc.strftime("%H:%M:%S")
    end
  end
end
