
require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

When /^(?:|I )click "([^\"]*)"?$/ do |button|
  click_button(button)
end

When /^(?:|I )fill in "([^\"]*)" with "([^\"]*)"?$/ do |field, value|
  fill_in(field, with: value)
end