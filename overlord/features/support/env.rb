require 'capybara'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'sinatra'
#require 'poltergeist'

require_relative '../../overlord.rb'

Capybara.app = Sinatra::Application.new

Capybara.configure do |config|
  config.app = Sinatra::Application.new
  config.default_selector = :css
  config.javascript_driver = :poltergeist
  config.server_port = 5678
  
  config.app_host = 'http://localhost:4567'
  config.always_include_port = true
  config.default_driver =  (d = ENV['CAPYBARA_DRIVER']) && d.to_sym || :selenium
  Capybara.default_wait_time = 5
end