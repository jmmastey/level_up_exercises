# Generated by cucumber-sinatra. (2014-08-18 13:58:33 -0500)
require 'capybara/poltergeist'
ENV['RACK_ENV'] = 'test'
ENV["HTTP_ACCEPT"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
require File.join(File.dirname(__FILE__), '..', '..', 'app/overlord.rb')
# require 'rubygems'
# require 'bundler/setup'
Bundler.require(:test)

Capybara.app = Overlord

include Capybara::Angular::DSL
include Rack::Test::Methods


Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, {debug: false})
end

Capybara.javascript_driver = :webkit
World(Rack::Test::Methods)
