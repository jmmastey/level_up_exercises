# config.ru (run with rackup)
require './overlord'

run Sinatra::Application.new
