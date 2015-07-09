#encoding: utf-8
require './classes/bomb.rb'

Given(/^I'm at the bomb page$/) do
  visit('/index')
  @bomb = Bomb.new
  @default_arm = '1234'
  @default_disarm = '0000'

  @my_arm_code = '8008'
  @my_disarm_code = '0880'

  @arm_actual = @my_arm_code
  @disarm_actual = @my_disarm_code
  @default_incorrect = '9999'
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

  answer = find(@panel + " .message p").text.to_i
  @bomb.codes[0] = answer

  binary = @bomb.sequence_for(0)
  binary[0] = 1 - binary[0] if incorrect

  binary.each_with_index do |val, button_number|
    next unless val == 1
    selector = ".columns > .column:first-child "
    selector << ".connector:nth-child(#{button_number+1})"
    find(selector).click
  end

  @bomb.attempt_hack(binary, 0)
end

When(/^I press submit on that panel$/) do
  submit_button = '.columns > '
  submit_button << '.column:first-child > '
  submit_button << 'input[type="submit"]'

  find(submit_button).click
end

Then(/^the panel should turn green$/) do
  find('.columns > .column.hacked')
end

Then(/^the panel buttons should reset$/) do
  find('.columns > .column:not(.hacked):first-child')

  (1..6).each do |button_number|
    selector = ".columns > .column:first-child "
    selector << ".connector:nth-child(#{button_number})"

    expect(find(selector).text).to eq('0')
  end
end

Given(/^I enter correct sequences for all panels$/) do
  (1..6).each do |panel|
    answer = find("#panel#{panel-1} .message p").text.to_i
    @bomb.codes[panel - 1] = answer

    binary = @bomb.sequence_for(panel-1)
    binary.each_with_index do |val, button_number|
      next unless val == 1
      selector = ".columns > .column:nth-child(#{panel}) "
      selector << ".connector:nth-child(#{button_number+1})"
      find(selector).click
    end

    submit_button = ".columns > "
    submit_button << ".column:nth-child(#{panel}) > "
    submit_button << "input[type='submit']"

    find(submit_button).click
  end

  @start_time = find('.minutes').text + find('.seconds').text
end

Then(/^the bomb should be hacked$/) do
  find('.bomb.hacked')
end