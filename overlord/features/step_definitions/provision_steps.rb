Given(/^a newly booted bomb$/) do
  on_visit(ProvisionPage).create_bomb
end

Given(/^the bomb provisioning page$/) do
  on_visit(ProvisionPage)
end

Given(/^a bomb provisioned with a custom activation code of "([^"]*)"$/) do |code|
  on_visit(ProvisionPage).create_bomb(activate: code)
end

Given(/^a bomb provisioned with a custom deactivation code of "([^"]*)"$/) do |code|
  on_visit(ProvisionPage).create_bomb(deactivate: code)
end

When(/^a bomb is booted for the first time$/) do
  on_visit(ProvisionPage).create_bomb
end
