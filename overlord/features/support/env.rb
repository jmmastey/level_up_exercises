require 'capybara/cucumber'
require_relative '../../overlord'
require_relative 'helpers'

Capybara.app = Sinatra::Application

Capybara.default_driver = :selenium

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end
