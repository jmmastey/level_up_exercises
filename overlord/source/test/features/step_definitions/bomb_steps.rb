# rubocop:disable all
load "main.rb"

Given /^an? (.+) bomb$/ do |s|
  expect($bomb.try(:status) || :unbooted).to eq(s.to_sym)
end

When /^I (?:.* )?(\w+) the bomb ?(.+)?$/ do |*args|
  action = args.shift
  args = args.compact.collect { |i| i.scan /"(\d+)"/ }.flatten
  bomb_does(*args.unshift(action))
end

Then /^the bomb should (?:be|remain|have) (.+)$/ do |s|
  expect($bomb.status).to eq(s.to_sym)
end

Then /^an? "(.+)" should have been (?:raised|thrown)$/ do |ex|
  exception_classes = $errors.collect(&:class).collect(&:to_s)
  expect(exception_classes).to include(ex)
  clear_errors
end
# rubocop:enable all
