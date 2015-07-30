Given(/^the bomb has exploded$/) do
  page.evaluate_script('BombStates.goToState(BombStates.EXPLODED)')
end

Then(/^the bomb should be disarmed$/) do
  bomb_state_should_be('activation')
end

Then(/^the bomb state should be (.+?)$/) do |state|
  bomb_state_should_be(state)
end

Then(/^the bomb lid should be open$/) do
  page.should have_css('#briefcase-lid.open')
end

def bomb_state_should_be(state)
  page.should have_css(".#{state}")
end
