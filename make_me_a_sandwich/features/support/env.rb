require "cucumber/rails"
require "vcr"

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile" \
        "(in the :test group) if you wish to use it."
end

Cucumber::Rails::Database.javascript_strategy = :truncation

Around do |scenario, block|
  DatabaseCleaner.cleaning(&block)
end

VCR.configure do |config|
  config.cassette_library_dir = "vcr"
  config.hook_into(:webmock)
end

VCR.cucumber_tags do |t|
  t.tag("@vcr")
end
