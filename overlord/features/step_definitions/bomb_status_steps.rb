Then(/^I should be redirected to a page with an active bomb$/) do
  expect(page).to have_selector('.bomb-bad')
end

Then(/^I should be redirected to a page with an inactive bomb$/) do
  expect(page).to have_selector('.bomb-neutral')
  expect(page).to_not have_selector('.bomb-good')
end

Then(/^I should be redirected to a page with a detonated bomb$/) do
  expect(page).to have_selector('.bomb-good')
  expect(page).to have_selector('.bomb-neutral')
end
