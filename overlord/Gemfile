# A sample Gemfile
source 'https://rubygems.org'

ruby '2.1.2'

gem 'activesupport', require: 'active_support/all'
gem 'i18n'
gem 'time_difference'
gem 'sinatra'
gem 'sinatra-contrib'
gem 'sinatra-partial', require: 'sinatra/partial'
gem 'datamapper', require: 'data_mapper'
gem 'bundler'
gem 'tux'


group :production do
  gem 'dm-postgres-adapter'
end


group :test do
  gem 'rspec-expectations', require: 'rspec/expectations'
  gem 'rack-test', require: 'rack/test'
  gem 'rspec'
  gem 'cucumber'
  gem 'cucumber-sinatra'
  gem 'capybara'
  gem 'nokogiri'
  gem 'selenium-webdriver'
  gem 'capybara-angular'
end

group :test, :development do
  gem 'dm-sqlite-adapter'
  gem 'debase'
  gem 'sass'
  gem 'compass'
  gem 'ruby-debug-ide'
end

