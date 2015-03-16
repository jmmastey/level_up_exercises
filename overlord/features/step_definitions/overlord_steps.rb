Given(/^I am on bomb interface page$/) do
  visit '/'
end

Then(/^On home page I see activation code box with default code$/) do
  checkcode('actcode', '1234')
end

Then(/^I see deactivation code box with default code$/) do
  checkcode('deactcode', '0000')
end

def checkcode(textbox, code)
  expect(page.find_by_id(textbox)[:placeholder]).to eq(code)
end

def fill_active_deactive_code(active_code, deactive_code)
  fill_in('actcode', with: active_code)
  fill_in('deactcode', with: deactive_code)
end

Then(/^I see "(.*?)" button$/) do |button_name|
  expect(has_button?(button_name)).to eq(true)
end

When(/^I set the activation and deactivation code$/) do
  fill_active_deactive_code('1111', '2222')
end

When(/^I click "(.*?)" button$/) do |button_name|
  click_button("#{button_name}")
end

Then(/^On bomb interface page$/) do
  visit '/bomb'
end

When(/^I enter incorrect activation and deactivation code$/) do
  fill_active_deactive_code('11', '22')
end

Then(/^I see popup "(.*?)"$/) do |arg1|
  expect(page.driver.browser.switch_to.alert.text).to eq(arg1)
end

Given(/^I am using default activation code$/) do
  visit('/')
  text_fill_action('actcode', '1234', 'Boot')
end

When(/^I enter default activation code$/) do
  text_fill_action('bombcode', '1234', 'Submit')
end

Then(/^Bomb is activated$/) do
  expect(page).to have_content('activated')
end

Given(/^I am using customized activation code$/) do
  visit('/')
  text_fill_action('actcode', '1111', 'Boot')
end

When(/^I enter custom activation code$/) do
  text_fill_action('bombcode', '1111', 'Submit')
  expect(page).to have_content('activated')
end

Given(/^Bomb is in active state$/) do
  visit('/')
  fill_in('actcode', with: '1234')
  text_fill_action('deactcode', '2222', 'Boot')
  text_fill_action('bombcode', '1234', 'Submit')
  expect(page).to have_content('activated')
end

When(/^I enter correct deactivation code$/) do
  text_fill_action('bombcode', '2222', 'Submit')
end

Then(/^Bomb is deactivated$/) do
  expect(page).to have_content('deactivated')
end

When(/^I enter incorrect deactivation code$/) do
  text_fill_action('bombcode', '3333', 'Submit')
end

Then(/^Bomb is in activated state$/) do
  expect(page).to have_content('activated')
end

When(/^I enter incorrect deactivation code "(.*?)" 3 times$/) do |bombcode|
  3.times do
    text_fill_action('bombcode', bombcode, 'Submit')
  end
end

Then(/^Bomb is in blast page$/) do
  visit '/blast'
end

def text_fill_action(textbox, code, button_name)
  fill_in(textbox, with: code)
  click_button(button_name)
end
