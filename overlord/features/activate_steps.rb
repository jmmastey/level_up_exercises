Given(/^I have booted the bomb$/) do
  @bomb = Bomb.new
end

When(/^I enter the right activation code$/) do
  @bomb.activate(Bomb::ACTIVATE_CODE)
end

Then(/^the bomb should activate$/) do
  expect(@bomb.active?).to be(true)
end