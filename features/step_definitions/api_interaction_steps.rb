Given(/^a artist search parameter$/) do
 artist = "andy-warhol"
end

When(/^I request artist data from the API$/) do
  RetrieveArtist.get_artist(artist)
end

Then(/^the new artist appears on the artists page$/) do
  expect(page).to have_content("Andy Warhol")
end
