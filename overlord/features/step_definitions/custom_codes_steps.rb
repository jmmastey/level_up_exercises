When(/^an invalid activation "([^"]*)" is provided$/) do |code|
  on(ProvisionPage).activation_code.set(code)
end

When(/^an invalid deactivation "([^"]*)" is provided$/) do |code|
  on(ProvisionPage).deactivation_code.set(code)
end

Then(/^the display indicates the activation code is invalid$/) do
  error_message = on(ProvisionPage).provision_error_message
  expect(error_message).to eq 'The activation code must be four numeric characters.'
end

Then(/^the display indicates the deactivation code is invalid$/) do
  error_message = on(ProvisionPage).provision_error_message
  expect(error_message).to eq 'The deactivation code must be four numeric characters.'
end
