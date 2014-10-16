require_relative 'overlord'

run Sinatra::Application

web: bundle exec rackup config.ru -p $PORT