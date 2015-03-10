Given(/^I am on bomb interface page$/) do
  visit '/'
end

Then(/^On home page I see activation code box with default code$/) do
  expect(page.find_by_id('activationcode')[:placeholder]).to eq('1234')
end

Then(/^I see deactivation code box with default code$/) do
  expect(page.find_by_id('deactivationcode')[:placeholder]).to eq('0000')
end

Then(/^I see "(.*?)" button$/) do |button_name|
  expect(has_button?(button_name)).to eq(true)
end

When(/^I set the activation and deactivation code$/) do
  fill_in('activationcode', with: '1111')
  fill_in('deactivationcode', with: '2222')
end

When(/^I click "(.*?)" button$/) do |button_name|
  click_button("#{button_name}")
end

Then(/^On bomb interface page$/) do
  visit '/bomb'
end

Given(/^I am using default activation code$/) do
  visit('/')
  fill_in('activationcode', with: '1234')
  click_button('Boot')
end

When(/^I enter default activation code$/) do
  fill_in('bombcode', with: '1234')
  click_button('Submit')
end

Then(/^Bomb is activated$/) do
  expect(page).to have_content('activated')
end

Given(/^I am using customized activation code$/) do
  visit('/')
  fill_in('activationcode', with: '1111')
  click_button('Boot')
end

When(/^I enter custom activation code$/) do
  fill_in('bombcode', with: '1111')
  click_button('Submit')
  expect(page).to have_content('activated')
end

Given(/^Bomb is in active state$/) do
  visit('/')
  fill_in('activationcode', with: '1234')
  fill_in('deactivationcode', with: '2222')
  click_button('Boot')
  fill_in('bombcode', with: '1234')
  click_button('Submit')
  expect(page).to have_content('activated')
end

When(/^I enter correct deactivation code$/) do
  fill_in('bombcode', with: '2222')
  click_button('Submit')
end

Then(/^Bomb is deactivated$/) do
  expect(page).to have_content('deactivated')
end

When(/^I enter incorrect deactivation code$/) do
  fill_in('bombcode', with: '3333')
  click_button('Submit')
end

Then(/^Bomb is in activated state$/) do
  expect(page).to have_content('activated')
end

When(/^I enter incorrect deactivation code "(.*?)" 3 times$/) do |bombcode|
  3.times do
    fill_in('bombcode', with: bombcode)
    click_button('Submit')
  end
end

Then(/^Bomb is in blast page$/) do
  visit '/blast'
end
