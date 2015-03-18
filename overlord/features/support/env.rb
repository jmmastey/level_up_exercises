require 'capybara'
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'selenium-webdriver'

require_relative "../../overlord"

Capybara.app = Sinatra::Application

Capybara.configure do |config|
  config.default_selector  = :css
  config.javascript_driver = :poltergeist
  config.default_driver    =  (d = ENV['CAPYBARA_DRIVER']) && d.to_sym || :selenium
  Capybara.default_wait_time = 10
end
