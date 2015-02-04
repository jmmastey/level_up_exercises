require 'bundler/setup'
require 'sinatra'
require 'sinatra/flash'

module Overlord
  class App < Sinatra::Base
    enable :sessions
    use Sinatra::Flash

    get '/' do
      session[:state] = :exploded if bomb_exploded?
      template = session[:state] || :index

      erb template
    end

    post '/start' do
      session[:activation_code]   = params[:activation_code]
      session[:deactivation_code] = params[:deactivation_code]
      session[:state]             = :started

      redirect to('/')
    end

    post '/activate' do
      if params[:activation_code] == session[:activation_code]
        session[:explosion_time]  ||= Time.now + params[:countdown].to_i
        session[:remaining_tries] ||= 3
        session[:state]             = :active
      else
        flash[:notice] = 'Wrong activation code'
      end
      redirect to('/')
    end

    post '/deactivate' do
      if params[:deactivation_code] == session[:deactivation_code]
        session[:state] = :deactivated
      else
        flash[:notice] = 'Wrong deactivation code'
        session[:remaining_tries] -= 1

        session[:state] = :exploded if session[:remaining_tries] < 1
      end
      redirect to('/')
    end

    get '/reset' do
      session.clear
      redirect to('/')
    end

    def valid_code?(code)
      code.scan(/\A\d+\z/).any?
    end

    def bomb_exploded?
      session[:state] == :active && session[:explosion_time] - Time.now <= 0
    end
  end
end
