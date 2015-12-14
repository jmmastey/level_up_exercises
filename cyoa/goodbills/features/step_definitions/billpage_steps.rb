When(/^I click an individual bill link$/) do
  first(:link, "Bill Detail").click
end

When(/^I am on the homepage$/) do
  visit('/')
end

Then(/^I should be on the individual bill page$/) do
  expect(current_url.include? 'bills').to be(true)
end

Then(/^there should be information about the bill$/) do
  expect(page).to have_content("summary")
end

Then(/^there should be voting controls$/) do
  expect(page).to have_content("Like")
  expect(page).to have_content("Dislike")
end

When(/^I am on an individual bill page$/) do
  visit('/#/bills/1')
end

When(/^I click the like button$/) do
  click_button('Like')
end

Then(/^the bill score should increase$/) do
  expect(page).to have_content("251")
end

When(/^I am on a different individual bill page$/) do
  visit('/#/bills/2')
end

When(/^I click the dislike button$/) do
  click_button('Dislike')
end

Then(/^the bill score should decrease$/) do
  expect(page).to have_content("249")
end
