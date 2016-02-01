$LOAD_PATH << 'lib'

require 'bomb'

When(/^I submit the the wrong de activation code three times$/) do
  visit("http://localhost:4567/")
  Bomb.new("1234", "0000")
  fill_in 'code', with: '1234'
  click_button 'Submit'

  3.times do
    fill_in 'code', with: '9999'
    click_button 'Submit'
  end
end

Then(/^the bomb will explode$/) do
  expect(page).to have_content 'The Bomb was Exploded. It went bang'
end
