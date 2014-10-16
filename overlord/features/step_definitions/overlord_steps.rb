Given(/^The bomb is not booted$/) do
  # do nothing, since the bomb isn't even booted yet
end

Given(/^I booted the bomb$/) do
  visit "/"
  click_button("boot-button")
end

Given(/^I activated the bomb$/) do
  fill_in("code", with: "1234")
  click_button("arm-button")
end
