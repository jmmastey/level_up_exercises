require 'capybara/cucumber'
require 'capybara'

Capybara.default_driver = :selenium
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :chrome
Capybara.configure do |config|
  config.run_server = false
  config.app_host = "localhost:4567"
end