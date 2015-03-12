# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'pry'

class Bomb

  MAX_ATTEMPTS = 3
  attr_reader :status, :incorrect_attempts, :activation_code

  def initialize (activation_code, deactivation_code)
    @activation_code = '1234'
    @deactivation_code = '0000'
    @activation_code = activation_code unless activation_code == ""
    @deactivation_code = deactivation_code unless deactivation_code == ""
    @attempts = 0
    @status = "booted"
  end

  def activate(code)
    if code == @activation_code
      @status = "active"
      true
    else
      false
    end
  end

  def deactivate(code)
    if code == @deactivation_code
      @status = "deactivated"
      true
    else
      incorrect_attempt
      false
    end
  end

  def detonate
    @status = "detonated"
  end

  def check_attempts
    if @attempts >= MAX_ATTEMPTS
      detonate
    end
  end

  def incorrect_attempt
    @attempts = @attempts + 1
    check_attempts
  end

end

enable :sessions

  @error = nil

  get '/' do
    session.clear
    erb :home
  end

  post '/' do
    session[:bomb] = Bomb.new(params['activation_code'], params['deactivation_code'])
    erb :activate
  end

  get '/activate' do
    erb :activate
  end

  post '/activate' do
    unless bomb.activate(params['activation_code'])
      @error = "Incorrect activation code entered"
      erb :activate
    else
      erb :countdown
    end
  end

  get '/countdown' do
    @message = nil
    erb :countdown
  end

  post '/countdown' do
    if bomb.status != "detonated"
      if bomb.deactivate(params['deactivation_code'])
        erb :saved
      elsif bomb.status == "detonated"
        erb :blast
      else
        @message = 'Incorrect deactivation code'
        erb :countdown
      end
    else
      erb :blast
    end
  end

  get '/blast' do
    erb :blast
  end

  get '/saved' do
    erb :saved
  end

  def bomb
    session[:bomb]
  end

