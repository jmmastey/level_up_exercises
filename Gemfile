source 'https://rubygems.org'
ruby '2.1.3'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0.beta2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0.beta1'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jQuery as the JavaScript library
gem 'jquery-rails', '~> 4.0.0.beta2'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Specify version of Arel to prevent error on database migrations
gem 'arel', '6.0.0.beta2'

# Add Bourbon, Neat, Bitters and Refills for styling
gem 'bourbon'
gem 'neat'
gem 'refills'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'debugger' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0.0.beta4'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Use RSpec for unit and functional tests
  gem 'rspec-rails', '~> 3.0'

  # Pry
  gem "pry-rails"

  # Awesome Print
  gem "awesome_print"

  # Cucumber
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

group :test do
  gem 'capybara'
  gem "launchy"
  gem "factory_girl_rails", "~> 4.0"
end

group :production do
  gem 'pg'
end

