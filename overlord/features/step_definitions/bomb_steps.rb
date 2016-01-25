Given(/^The bomb has not been initialized$/) do
  @bomb = nil
end

Given(/^The bomb has been initialized$/) do
  visit('/')
  page.find('#initialize').click
end

Given(/^the bomb has been activated$/) do
  visit('/')
  fill_in('actcode', with: '1234')
  page.find('#activate').click
end

Given(/^the bomb has been initialized with activation code "(.*?)"$/) do |code|
  visit('/')
  fill_in('actcode', with: code)
  page.find('#initialize').click
end

Given(/^the bomb has been initialized w deactivation code "(.*?)"$/) do |code|
  visit('/')
  fill_in('bomb-deactivation-code', with: code)
  page.find('#initialize').click
end

Given(/^I enter an incorrect code three times$/) do
  visit('/')
  fill_in('bomb-deactivation-code', with: "wrong")
  page.find('#deactivate').click
  fill_in('bomb-deactivation-code', with: "wrong")
  page.find('#deactivate').click
  fill_in('bomb-deactivation-code', with: "wrong")
  page.find('#deactivate').click
end

When(/^I confirm the pop\-up dialog$/) do
  page.driver.browser.switch_to.alert.accept
end
