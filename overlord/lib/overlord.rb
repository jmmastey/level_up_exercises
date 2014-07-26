module Overlord
  class Bomber < Sinatra::Base

    use Rack::Session::Pool, :expire_after => 360000
    # set :root, File.dirname(__FILE__)
    # set :public_folder, '../public'
    set :public_folder, 'public'


    helpers do
      def username
        session[:identity] ? session[:identity] : 'Hello stranger'
      end
    end

    get '/' do
      # "Time to build an app around here. Start time: " + start_time
      erb :off
    end

    get '/boot_process' do
      # https://gist.github.com/havvg/3226804
      erb :boot_process
    end

    post '/stand_by' do

      puts params

      erb :stand_by
    end

    get '/activate' do
      erb :activate
    end

    post '/activated' do
      erb :activated
    end

    get '/deactivate' do
      erb :deactivate
    end

    get '/boom' do
      # status 521
      erb :boom
    end

    # we can shove stuff into the session cookie YAY!
    def start_time
      session[:start_time] ||= (Time.now).to_s
    end

  end
end
