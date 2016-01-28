def zeus_running?
  File.exist?(".zeus.sock")
end

ENV["RAILS_ENV"] ||= "test"

unless zeus_running?
  require "simplecov"
  SimpleCov.start("rails")
end

require "rails/all"
require "webmock/rspec"
require "database_cleaner"
require "spec_helper"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include Devise::TestHelpers, type: :view
end
