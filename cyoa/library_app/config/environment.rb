require 'capybara/rails'
require 'cucumber'
Capybara.default_driver = :selenium
# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
