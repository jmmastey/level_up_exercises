Given(/^a provisioned bomb$/) do
  on_visit(ProvisionPage).create_bomb
end

Given(/^the bomb provisioning page$/) do
  on_visit(ProvisionPage)
end

Given(/^an activated bomb$/) do
  on_visit(ProvisionPage).create_bomb
  on(BombPage) do |page|
    page.enter_code('1234')
    page.activate_bomb
  end
end

Given(/^a provisioned bomb with a custom activation code$/) do
  on_visit(ProvisionPage).create_bomb(activate: '9292')
end

Given(/^a provisioned bomb with a custom deactivation code$/) do
  on_visit(ProvisionPage).create_bomb(deactivate: '1138')
end

Given(/^a provisioned bomb with a custom countdown value$/) do
  on_visit(ProvisionPage).create_bomb(countdown: 15)
end

When(/^an invalid custom activation "([^"]*)" is provided$/) do |code|
  on(ProvisionPage).create_bomb(activate: code)
end

When(/^an invalid custom deactivation "([^"]*)" is provided$/) do |code|
  on(ProvisionPage).create_bomb(deactivate: code)
end

When(/^an invalid custom countdown "([^"]*)" is provided$/) do |value|
  on(ProvisionPage).create_bomb(countdown: value)
end

Then(/^the user is told the custom activation code is invalid$/) do
  error_message = on(ProvisionPage).provision_error_message
  expect(error_message)
    .to eq('The activation code must be four numeric characters.')
end

Then(/^the user is told the custom deactivation code is invalid$/) do
  error_message = on(ProvisionPage).provision_error_message
  expect(error_message)
    .to eq('The deactivation code must be four numeric characters.')
end

Then(/^the user is told the custom countdown value is invalid$/) do
  error_message = on(ProvisionPage).provision_error_message
  expect(error_message)
    .to eq('The countdown value must be a whole number.')
end
