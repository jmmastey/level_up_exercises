Given(/^The bomb is not booted$/) do
  # do nothing, since the bomb isn't even booted yet
end

Given(/^I booted the bomb$/) do
  visit "/"
  click_button("arm-button")
end

Given(/^I activated the bomb$/) do
  fill_in("code", with: "1234")
  click_button("arm-button")
end

When(/^I visit the bomb booting page$/) do
  visit "/"
end
