require 'sinatra'
require './bomb'
require 'timers'
require 'eventmachine'

enable :sessions
set :public_folder, proc { File.join(File.dirname(__FILE__), 'views') }
set :bind, '0.0.0.0'

get '/' do
  session.clear
  erb :overlord
end

post '/boot' do
  session[:bomb] = Bomb.new(params['activationcode'],
                            params['deactivationcode'])
  redirect '/bomb'
end

get '/bomb' do
  erb :bomb,
      locals:
        {
          incorrect_attempts: bomb.incorrect_attempts,
          bomb_status: bomb.status
        }
end

post '/bomb' do
  input_code = params['bombcode']
  bomb.check_input_code(input_code)

  if bomb.incorrect_attempts == 3
    redirect '/blast'
  else
    erb :bomb,
        locals:
          {
            incorrect_attempts: bomb.incorrect_attempts,
            bomb_status: bomb.status
          }
  end
end

get '/blast' do
  erb :blast
end

def bomb
  session[:bomb]
end
