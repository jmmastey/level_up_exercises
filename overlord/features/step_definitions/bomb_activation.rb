Given(/^the bomb is not active$/) do
  bomb = Bomb.new
  expect(bomb).not_to be_active # expectations only in then
end

When(/^I send the bomb the code "(.*?)"$/) do |code|
  bomb.activate(code.to_i)
end

Then(/^the bomb should be active$/) do
  fail "Bomb is not active" unless bomb.active?
end

Then(/^the bomb should not be active$/) do
  fail "Bomb is active" if bomb.active?
end

Given(/^the bomb is active with code "(.*?)$/) do |code|
  bomb = Bomb.new
  bomb.activate(code.to_i)
  fail "Bomb is not active" unless bomb.active?
end

Then(/^the bomb shoud throw an error$/) do
  pending # express the regexp above with the code you wish you had
end
