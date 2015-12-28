def create_merchants_with_zip(zip, count)
  FactoryGirl.create_list(:location, count, zip: zip).map do |location|
    FactoryGirl.create(:merchant, location: location)
  end
end

def search_merchants(location)
  VCR.use_cassette("search_merchants_at_#{location}") do
    find_by_id("location").set(location)
    click_button "Search"
  end
end

Given(/^I am on the merchant index$/) do
  visit merchants_path
end

When(/^I search a matching ZIP$/) do
  search_merchants("60604")
end

When(/^I search without a ZIP$/) do
  search_merchants("")
end

Then(/^I see the merchants matching that ZIP$/) do
  expect(page).not_to have_content("No merchants found")
end

Then(/^I see there are no matching merchants$/) do
  expect(page).to have_content("No merchants found")
end

Then(/^I see I must enter a ZIP$/) do
  expect(page).to have_content("You must enter a ZIP to search by")
end
