#encoding: utf-8
require './classes/bomb.rb'

Given(/^an armed bomb$/) do
  @bomb = Bomb.new
end

When(/^it generates panel codes$/) do
  @bomb.codes
end

Then(/^they should be less than 64$/) do
  @bomb.codes.all? do |panel_code|
    panel_code < 64
  end
end

Then(/^greater than 0$/) do
  @bomb.codes.all? do |panel_code|
    panel_code > 0
  end
end

Given(/^a panel on that bomb$/) do
  panels = (0..5).to_a.sample(2)
  @panel = panels[0]
  @other_panel = panels[1]
end

Given(/^the code for that panel$/) do
  @code = @bomb.codes[@panel]
end

When(/^I enter the correct sequence$/) do
  @correct_sequence = @bomb.sequence_for(@panel)
end

When(/^I enter the incorrect sequence$/) do
  @incorrect_sequence = @bomb.sequence_for(@other_panel)
end

Then(/^it should hack the panel$/) do
  @bomb.attempt_hack(@correct_sequence, @panel)
  @bomb.hacked?(@panel) == true
end

Then(/^it should not hack the panel$/) do
  @bomb.attempt_hack(@incorrect_sequence, @panel)
  @bomb.hacked?(@panel) == false
end