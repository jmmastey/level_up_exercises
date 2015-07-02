#encoding: utf-8

Given(/^the bomb is armed$/) do
  selector = ".bomb.armed"
  find(selector)
end

Then(/^the bomb should (not )?disarm$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the timer should (not )?stop$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end