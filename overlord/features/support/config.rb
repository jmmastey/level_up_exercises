require_relative "../../overlord.rb"
require "capybara/cucumber"
Capybara.app = Sinatra::Application
