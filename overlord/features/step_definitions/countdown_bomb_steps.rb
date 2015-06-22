When(/^(\d+) seconds has passed$/) do |arg1|
  sleep(10)
end

Then(/^my bomb should explode$/) do
  expect(page).to have_content('Oops! You blew it!')
end