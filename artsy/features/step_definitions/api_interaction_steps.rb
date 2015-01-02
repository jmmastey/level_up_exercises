Given(/^I request artist data from the API for (.+)$/) do |name|
  full_name = name.downcase.gsub(/\s/, '-')
  artist = RetrieveArtist.new(full_name)
  artist.update_record
end

When(/^I visit the artists page$/) do
  visit artists_path
end

Then(/^(.+) appears on the artists page$/) do |name|
  expect(page).to have_content(name)
end
