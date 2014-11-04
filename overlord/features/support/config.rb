require_relative "../../overlord.rb"
require "capybara/cucumber"
require "capybara-webkit"
Capybara.app = Sinatra::Application
Capybara.javascript_driver = :webkit
