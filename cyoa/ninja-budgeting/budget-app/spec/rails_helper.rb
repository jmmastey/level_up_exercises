# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'capybara/rails'
require 'rack_session_access/capybara'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist

OmniAuth.config.test_mode = true
omniauth_hash = {
  provider: 'google_oauth2',
  uid: '123456789',
  info: {
    name: 'John Doe',
    email: 'john@company_name.com',
    first_name: 'John',
    last_name: 'Doe',
    image: 'https://lh3.googleusercontent.com/url/photo.jpg'
  },
  credentials: {
    token: 'token',
    refresh_token: 'another_token',
    expires_at: 1354920555,
    expires: true
  },
  extra: {
    raw_info: {
      sub: '123456789',
      email: 'user@domain.example.com',
      email_verified: true,
      name: 'John Doe',
      given_name: 'John',
      family_name: 'Doe',
      profile: 'https://plus.google.com/123456789',
      picture: 'https://lh3.googleusercontent.com/url/photo.jpg',
      gender: 'male',
      birthday: '0000-06-25',
      locale: 'en',
      hd: 'company_name.com'
    },
    id_info: {
      'iss' => 'accounts.google.com',
      'at_hash' => 'HK6E_P6Dh8Y93mRNtsDB1Q',
      'email_verified' => 'true',
      'sub' => '10769150350006150715113082367',
      'azp' => 'APP_ID',
      'email' => 'jsmith@example.com',
      'aud' => 'APP_ID',
      'iat' => 1353601026,
      'exp' => 1353604926,
      'openid_id' => 'https://www.google.com/accounts/o8/id?id=ABCdfdswawerSDFDsfdsfdfjdsf'
    }
  }
}
OmniAuth.config.add_mock(:google, omniauth_hash)

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!
end
