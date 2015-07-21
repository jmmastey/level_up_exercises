Given(/^a newly booted bomb$/) do
  on_visit(TriggerPage)
  # Need to make this ProvisionPage and have it click provision button.
end

Given(/^a bomb provisioned with a custom activation code of "([^"]*)"$/) do |code|
  on_visit(ProvisionPage).create_bomb(activate: code)
end
