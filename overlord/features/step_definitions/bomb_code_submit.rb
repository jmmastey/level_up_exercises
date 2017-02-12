# encoding: utf-8

When(/^I press Submit Codes$/) do
  find('#submit-codes').click
end

When(/^I enter nothing$/) do
  @arm_actual = @default_arm
  @disarm_actual = @default_disarm
end

When(/^I enter the (dis)?arm code only$/) do |disarm|
  if disarm
    @disarm_actual = @my_disarm_code
    @arm_actual = @default_arm
    find('#disarm-code-input').set(@disarm_actual)
  else
    @arm_actual = @my_arm_code
    @disarm_actual = @default_disarm
    find('#arm-code-input').set(@arm_actual)
  end
end

When(/^I enter both the arm and disarm code$/) do
  @disarm_actual = @my_disarm_code
  @arm_actual = @my_arm_code
  find('#disarm-code-input').set(@disarm_actual)
  find('#arm-code-input').set(@arm_actual)
end

When(/^I enter incorrect codes$/) do
  find('#disarm-code-input').set('THIS WONT WORK')
  find('#arm-code-input').set('AND NEITHER WILL THIS')
end

Then(/^a flash message should appear$/) do
  expect(find('.flash').text).not_to eq('')
end

Then(/^the dialog should not disappear$/) do
  find('.code-input')
end
