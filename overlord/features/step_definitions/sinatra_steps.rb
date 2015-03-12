Given /^I am on the home page$/ do
  visit "/"
end

Then /^I should be able to enter the activation_code$/ do
  expect(page.find_by_id('activation_code')[:placeholder]).to eq('1234')
end

Then /^I should be able to confirm the activation_code$/ do
  expect(page.find_by_id('reactivation_code')[:placeholder]).to eq('1234')
end

Then /^I should be able to enter the deactivation_code$/ do
  expect(page.find_by_id('deactivation_code')[:placeholder]).to eq('0000')
end

When /^I set the activation and deactivation code$/ do
  fill_in('activation_code', with: '1234')
  fill_in('reactivation_code', with: '1234')
  fill_in('deactivation_code', with: '0000')
end

When /^I click "(.*?)"$/ do |button|
  click_button("#{button}")
end

Then /^I am taken to the activation page$/ do
  visit '/activate'
end

Given /^The bomb is Armed$/ do
  visit '/'
  click_button('Arm')
end

Then /^I should be able to enter the activation code$/ do
  expect(page.find_by_id('activation_code')).to be_truthy
end

When /^I enter an incorrect "(.*?)"$/ do |code|
  fill_in("#{code}", with: '4567')
end

Then /^the bomb doesn't activate$/ do
  click_button('Activate')
  expect(page.find_by_id('status')).to be_truthy
end

When /^I enter the correct activation_code$/ do
  fill_in('activation_code', with: '1234')
end

Then /^the bomb is activated$/ do
  click_button('Activate')
  expect(page.find_by_id('deactivation')).to be_truthy
end

Given /^The bomb is activated$/ do
  visit '/'
  click_button('Arm')
  fill_in('activation_code', with: '1234')
  click_button('Activate')
  expect(page.find_by_id('deactivation')).to be_truthy
end

Then /^the bomb doesn't deactivate$/ do
  click_button('Deactivate')
  expect(page.find_by_id('deactivation')).to be_truthy
end

When /^I enter the correct deactivation code$/ do
  fill_in('deactivation_code', with: '0000')
end

Then /^the bomb is deactivated$/ do
  click_button('Deactivate')
  expect(page.find_by_id('saved')).to be_truthy
end

When /^I enter the incorrect deactivation code thrice$/ do
  3.times do
    fill_in('deactivation_code', with: '4567')
    click_button('Deactivate')
  end
end

Then /^the bomb should explode$/ do
  expect(page.find_by_id('blast')).to be_truthy
end

