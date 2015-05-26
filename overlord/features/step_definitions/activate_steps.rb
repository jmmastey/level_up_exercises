Given(/^I am on the activate bomb page$/) do
  visit "/"
end

 
When(/^Code (\d+) Entered$/) do |code|
  @code = code 
end


Then(/^I see the countdown start$/) do
  expect(page).to have_content('Countdown')
end

