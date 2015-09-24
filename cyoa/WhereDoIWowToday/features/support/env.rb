require 'cucumber/rails'
require 'webmock/cucumber'

ActionController::Base.allow_rescue = false

DatabaseCleaner.strategy = :truncation
Cucumber::Rails::Database.javascript_strategy = :truncation

module WebMockWorld
  include WebMock::API
  include WebMock::Matchers
end
World(WebMockWorld)
