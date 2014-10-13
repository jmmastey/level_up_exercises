Given(/^The bomb is not booted$/) do
  # do nothing, since the bomb isn't even booted yet
end

# Given(/^The bomb is available$/) do
#   visit "/bomb"
# end

When(/^I visit the bomb booting page$/) do
  visit "/"
end
