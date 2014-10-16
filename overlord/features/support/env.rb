require File.dirname(__FILE__) + '/../../overlord'

begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'rack/test'
require 'capybara/cucumber'
Capybara.app = Sinatra::Application