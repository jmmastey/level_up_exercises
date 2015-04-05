Given(/^I am the only user$/) do
  users = User.all
  expect(users.length).to eq(1) 
end

When(/^I visit the users page$/) do
  visit("/users")
end

Then(/^I should see a single user listing$/) do
  listings = all("section.user-info")
  expect(listings.length).to eq(1)
end

Given(/^there are (\d+) existing users$/) do |num|
  (num.to_i - 1).times { |_| FactoryGirl.create(:user, password: PASSWORD) }
end

Then(/^I should see (\d+) user listings$/) do |num|
  listings = all("section.user-info")
  expect(listings.length).to eq(num.to_i)
end
