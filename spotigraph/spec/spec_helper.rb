require 'simplecov'
SimpleCov.start 'rails'
RSpec.configure do |config|
  # Computer Generated
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  # Computer Generated
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  # Ensure we hit the tests in /spec/lib
  config.pattern = '**/*_spec.rb'
  # Use color in STDOUT
  config.color = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate

  # Clean and seed the db before tests. Ensures we don't have flaky tests due to
  # Spotify updating a given artist's related artists
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    Rails.application.load_seed # loading seeds
  end
end
