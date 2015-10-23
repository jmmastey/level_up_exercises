ENV['RAILS_ENV'] ||= 'test'
require 'rspec/rails'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
