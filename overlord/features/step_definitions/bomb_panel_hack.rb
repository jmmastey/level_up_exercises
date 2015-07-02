#encoding: utf-8
require './classes/bomb.rb'

Given(/^I'm at the bomb page$/) do
  visit('/index')
  @bomb = Bomb.new
end

When(/^I press a (\d+) button on a panel$/) do |arg1|
  selector = '.columns'
  selector << ' .column:first-child'
  selector << ' .connector:first-child'

  if arg1 == '0'
    selector << ':not(.depressed)'
  else
    find(selector).click
    selector << '.depressed'
  end

  find(selector).click
end

Then(/^it should change its value to (\d+)$/) do |arg1|
  selector = '.columns'
  selector << ' .column:first-child'
  selector << ' .connector:first-child'
  
  if arg1 == '0'
    selector << ':not(.depressed)'
  else
    selector << '.depressed'
  end

  find(selector).has_content?(arg1)
end

Given(/^I choose a panel$/) do
  @panel = "#panel0"
end

Given(/^the depressed buttons on the panel form a(?:n)? (in)?correct sequence$/) do |incorrect|
  selector = @panel
  if(incorrect)
    selector << " .message p"
    puts find(selector).content
  else 

  end
end

When(/^I press submit on that panel$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the panel should turn green$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the panel buttons should reset$/) do
  pending # Write code here that turns the phrase above into concrete actions
end