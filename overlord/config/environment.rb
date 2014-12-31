require "rubygems"
require "bundler"

# load all the default gems
Bundler.require(:default)
# load all the environment specific gems
Bundler.require(Sinatra::Base.environment)

APP_PATH = (File.dirname __FILE__) + "./../app/"
