require 'capybara'
require 'capybara/cucumber'
require 'rspec'
require 'selenium/webdriver'
require 'capybara/rspec'

Capybara.default_driver = :selenium
Capybara.ignore_hidden_elements = false
