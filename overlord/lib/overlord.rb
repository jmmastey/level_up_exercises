require 'logger'

module Overlord
  class Bomber < Sinatra::Base

    LOG = Logger.new(STDOUT)

    use Rack::Session::Pool, :expire_after => 360000
    set :public_folder, 'public'

    helpers do

      def is_boomed?
        boom_time = session[:boom_time]
        return false if boom_time.nil?
        boom_time < Time.now
      end

      def booted?
        !session[:activation_code].nil?
      end

      def activated?
        !session[:boom_time].nil?
      end

      def valid_code?(code)
        code.match(/^[0-9]{4}$/).size == 1
      end

      def allow_deactivation?(code)
        session[:deactivation_code].eql?(code)
      end

      def allow_activation?(code)
        session[:activation_code].eql?(code)
      end

      def inc_deact_count
        if session[:bad_deact_count].nil?
          session[:bad_deact_count] = 1
        else
          session[:bad_deact_count] += 1
        end

      end

      def inc_act_count
        if session[:bad_act_count].nil?
          session[:bad_act_count] = 1
        else
          session[:bad_act_count] += 1
        end
      end

      def clear_out
        session[:deactivation_code] = nil
        session[:activation_code] = nil
        session[:bad_deact_count] = 0
        session[:bad_act_count] = 0
        session[:boom_time] = nil
      end

      def template
        "<script type=\"text/template\" id=\"main-example-template\">
        <div class=\"time <%= label %>\">
        <span class=\"count curr top\"><%= curr %></span>
        <span class=\"count next top\"><%= next %></span>
        <span class=\"count next bottom\"><%= next %></span>
        <span class=\"count curr bottom\"><%= curr %></span>
        <span class=\"label\"><%= label.length < 6 ? label : label.substr(0, 3)  %></span>
        </div>
        </script>"
      end

    end

    get '/' do
      redirect to('/activated') if activated?
      redirect to('/stand_by') if booted?
      erb :off
    end

    get '/boot_process' do
      redirect to('/activated') if activated?
      redirect to('/stand_by') if booted?

      erb :boot_process

    end

    post '/stand_by' do

      # validations?
      activation = params[:post]["activation-code"]
      deactivation = params[:post]["deactivation-code"]

      if !valid_code?(activation) || !valid_code?(deactivation)
        redirect to('/boot_process')
      end

      session[:activation_code] = activation
      session[:deactivation_code] = deactivation

      erb :stand_by

    end

    get '/stand_by' do
      redirect to('/activated') if activated?
      redirect to('/') if !booted?
      erb :stand_by
    end

    get '/activate' do

      if session[:bad_act_count].nil? || session[:bad_act_count] == 0
        @remaining_attempts = nil
      else
        @remaining_attempts = 3 - session[:bad_act_count]
      end

      erb :activate
    end

    post '/activated' do
      redirect to('/') if !booted?

      if !activated?
        activation = params[:post]["activation-code"]
        seconds = params[:post]["seconds-to-boom"].to_i #exceptions?

        if allow_activation?(activation)
          session[:bad_act_count] = 0
          session[:boom_time] = Time.now + seconds
        else
          inc_act_count
          if session[:bad_act_count] >= 3
            redirect to('/boom')
          else
            redirect back
          end
        end
      end

      @template = template
      @seconds = session[:boom_time] - Time.now
      @boom_time = session[:boom_time]

      erb :activated

    end

    get '/activated' do
      redirect to('/stand_by') if !activated?
      redirect to('/') if !booted?

      if is_boomed?
        puts "We are all dead"
        redirect to('/boom')
      else
        @template = template
        @seconds = session[:boom_time] - Time.now
        @boom_time = session[:boom_time]
        erb :activated
      end
    end


    get '/deactivate' do
      redirect to('/') if !booted?

      if session[:bad_deact_count].nil? || session[:bad_deact_count] == 0
        @remaining_attempts = nil
      else
        @remaining_attempts = 3 - session[:bad_deact_count]
      end

      erb :deactivate
    end

    post '/deactivated' do
      # back to Standby?
      # if valid deactivation code
      redirect to('/stand_by') # Will need to make stand_by a get request as well
    end

    get '/boom' do
      clear_out
      erb :boom, :layout => :boom_layout
    end

    post '/power_off' do
      deactivation = params[:post]["deactivation-code"]

      if allow_deactivation?(deactivation)
        clear_out
        redirect to('/')
      else
        inc_deact_count

        if session[:bad_deact_count] >= 3
          redirect to('/boom')
        else
          redirect back
        end

      end

    end



  end
end
