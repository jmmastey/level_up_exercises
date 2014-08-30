require 'sinatra'
require 'sinatra/json'
require 'json'
require ''

class Overlord < Sinatra::Base
  enable :sessions
  set :static => true
  # set :public_folder, File.dirname(__FILE__) + '../public'


  get '/' do
    session
    session[:activationCode] ||= nil
    session[:deactivationCode] ||= nil
    session[:detonationCode] ||= nil

    erb :index, :layout => :base, locals: {:keypad_numbers => keypad_numbers,
                                           :last_row => keypad_last_row,
                                           :control_row => keypad_control_row}
  end


  helpers do
    def is_codeset?(sesh, code)
      if !sesh[code].nil?
        json :status => 'code already set'
        json :body => code.to_s
        halt 302
      end
    end

    def check_or_set_code(code, value, type:nil)
      if is_code_set?(code) && session[code] == value
        json :errors => [code.to_s, 'same code']
      else
        if is_code_long_enough?(code, value) && type.nil?
          session[code] = value
        else
          session[code] = Time.now
        end
      end
    end

    def is_code_long_enough?(code, value)
      true
      if value.to_s.length < 4
        json :errors => [code.to_s, 'not long enough' ]
        false
      end
    end

    def is_code_set?(code)
      !session[code].nil?
    end



    def is_i?(code)
      !!(code =~ /\A[-+]?[0-9]+\z/)
    end
  end

  error 400 do
    json :status => 'code not long enough'

  end

  error 406 do
    json :status => 'invalid code'
  end

  # get '/bomb' do
  #   200
  # end


  post '/bomb/*' do
    codes = JSON.parse(request.body.read.to_s)
    codes.each_key do |key|
      code = String(key).to_sym
      value = Integer(codes[key])
      check_or_set_code(code, value)
    end
  end


  post '/deactivation/:code' do
    session[:bomb] = false

  end

  get '/explode' do
    json :status => 'boom'

  end
  # we can shove stuff into the session cookie YAY!
  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  def keypad_numbers
    values = []
    keypadrow = []
    for value in 1...4 do
      keypadrow << {value: value.to_s, class: 'btn-info'}
    end
    values << keypadrow
    keypadrow = []
    for value in 4...7 do
      keypadrow << {value: value.to_s, class: 'btn-info'}
    end
    values << keypadrow
    keypadrow = []
    for value in 7...10 do
      keypadrow << {value: value.to_s, class: 'btn-info'}
    end
    values << keypadrow
    keypadrow = []
    values
  end

  def keypad_control_row
    values = []
    values << {value: 'Deactivate', class: 'btn-danger'}
    values << {value: 'Activate', class: 'btn-success'}
    values
  end

  def keypad_last_row
    values = []
    values << {value: 'C', class: 'btn-danger glyphicon glyphicon-remove'}
    values << {value: '0', class: 'btn-info'}
    values << {value: 'S', class: 'btn-success glyphicon glyphicon-ok'}
  end


  run! if app_file == $0

end

