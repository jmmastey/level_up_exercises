
require 'cucumber/rails'

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :truncation
rescue NameError
  raise "You need to add database_cleaner"
end

Cucumber::Rails::Database.javascript_strategy = :truncation

# Clean the database before and after each scenario
Before do
  DatabaseCleaner.start
end

After do
  DatabaseCleaner.clean
end

# Register Chrome as the default driver
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :chrome
Capybara.default_driver = :selenium
