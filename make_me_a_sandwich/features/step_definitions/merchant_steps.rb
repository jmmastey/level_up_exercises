def create_merchants_with_zip(zip, count)
  FactoryGirl.create_list(:location, count, zip: zip).map do |location|
    FactoryGirl.create(:merchant, location: location)
  end
end

def search_merchants(location)
  find_by_id("location").set(location)
  click_button "Search"
end

Given(/^I am on the merchant index$/) do
  visit merchants_path
end

Given(/^some merchants exist$/) do
  @merchants = FactoryGirl.create_list(:merchant, 10)
  @merchants.concat(create_merchants_with_zip("60604-1234", 5))
  @merchants.concat(create_merchants_with_zip("60604-2345", 5))
end

When(/^I search a matching ZIP$/) do
  search_merchants("60604-1234")
end

When(/^I search a matching ZIP without the 4-digit extension$/) do
  search_merchants("60604")
end

When(/^I search a non\-matching ZIP$/) do
  search_merchants("00000")
end

When(/^I search without a ZIP$/) do
  search_merchants("")
end

Then(/^I see the merchants matching that ZIP$/) do
  merchants = @merchants.select { |m| m.location.zip == "60604-1234" }
  merchants.each do |merchant|
    expect(page).to have_content(merchant.name)
  end
end

Then(/^I see the merchants matching that partial ZIP$/) do
  merchants = @merchants.select { |m| m.location.zip.start_with?("60604") }
  merchants.each do |merchant|
    expect(page).to have_content(merchant.name)
  end
end

Then(/^I do not see the merchants not matching that ZIP$/) do
  merchants = @merchants.reject { |m| m.location.zip == "60604-1234" }
  merchants.each do |merchant|
    expect(page).not_to have_content(merchant.name)
  end
end

Then(/^I see there are no matching merchants$/) do
  expect(page).to have_content("No merchants found")
end

Then(/^I see I must enter a ZIP$/) do
  expect(page).to have_content("You must enter a ZIP to search by")
end
