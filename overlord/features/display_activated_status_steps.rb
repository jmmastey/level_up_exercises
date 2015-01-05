Given(/^I have booted the bomb$/) do
  @bomb = Bomb.new
end

When(/^the bomb has been activated$/) do
  @bomb.activate(Bomb::ACTIVATE_CODE)
end

Then(/^the status indicator should show as activated$/) do
  status
end