Given(/^A new bomb is not active$/) do
  @bomb = Bomb.new
  @bomb.state = :inactive
end

When(/^I start the application$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the game should say “Welcome to Blow people up”$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the game should say “Enter code: and the current state of the bomb”$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
