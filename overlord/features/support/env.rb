require 'selenium-webdriver'
require 'capybara'
require 'capybara/cucumber'
require 'rspec'
require_relative '../../overlord'

Capybara.app = Overlord
Capybara.default_driver = :selenium

def http_delete(path)
  current_driver = Capybara.current_driver
  Capybara.current_driver = :rack_test
  page.driver.submit :delete, path, {}
  Capybara.current_driver = current_driver
end
