module Overlord
  class Bomber < Sinatra::Base

    use Rack::Session::Pool, :expire_after => 360000
    set :public, 'public'

    helpers do
      def username
        session[:identity] ? session[:identity] : 'Hello stranger'
      end
    end

    get '/' do
      # "Time to build an app around here. Start time: " + start_time
      erb(:off)
    end

    get '/boom' do
      puts "Sorry, we're dead..."
      halt 521
    end

    # we can shove stuff into the session cookie YAY!
    def start_time
      session[:start_time] ||= (Time.now).to_s
    end

  end
end
