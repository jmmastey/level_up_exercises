require 'sinatra/base'

class Overlord < Sinatra::Base
  get '/' do
    'Hello Overlord!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
