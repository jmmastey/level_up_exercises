RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with(:rspec) do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    FactoryGirl.lint
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end

  VCR.configure do |config|
    config.cassette_library_dir = "fixtures/vcr"
    config.hook_into(:webmock)
  end
end
