Given(/^I request artist data from the API$/) do
  ArtsyApiWrapper.get_artist("andy-warhol")
end

When(/^I visit the artists page$/) do
  visit artists_path
end

Then(/^the new artist appears on the artists page$/) do
  expect(page).to have_content("Andy Warhol")
end
