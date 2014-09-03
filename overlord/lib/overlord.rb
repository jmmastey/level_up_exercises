require File.expand_path(File.dirname(__FILE__) + '/overlord_helpers.rb')
require 'sinatra'
require 'sinatra/json'
require 'sinatra/partial'
require 'json'
require 'active_support/all'
require 'time_difference'

class Overlord < Sinatra::Base
  include OverlordHelpers
  register Sinatra::Partial
  set :partial_template_engine, :erb
  enable :sessions
  enable :partial_underscores

  set :static => true
  # set :public_folder, File.dirname(__FILE__) + '../public'


  get '/' do
    erb :index, :layout => :base, locals: {:keypad_numbers => keypad_numbers,
                                           :last_row => keypad_last_row,
                                           :control_row => keypad_control_row}
  end

  get '/reset' do
    session.clear
    redirect to('/')
  end



  helpers do

  end


  post '/bomb/deactivate/:deactivactionCode' do
    session[:bombActive] = false
    redirect to('/')

  end

  bomb_vars = %w(activationCode deactivationCode detonationCode)
  post '/bomb/'+bomb_vars.map{|v|":#{v}"}.join('/') do
    errors = {}


    bomb_vars.each do |key|
      code = key.to_sym
      value = params[code]
      error = check_or_set_code(code, value)
      errors[code] = error unless error.nil?
    end
    # body.join('; ')
    if errors.empty?

      session[:bombActive] = true
      session[:detonationTime] = detonation_time
      res = {:detonation => detonation_time}
      body res.to_json
      200
    else
      body errors.to_json
      session[:bombActive] = false
      400
    end

  end

  after do
    puts body
  end


  get '/explode' do
    json :status => 'boom'

  end

  run! if app_file == $0

end

