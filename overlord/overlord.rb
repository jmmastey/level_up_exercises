require 'sinatra/base'
require_relative 'detonator'

class Overlord < Sinatra::Base
  get '/' do
    @detonator = Detonator.new
    erb :detonator
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
