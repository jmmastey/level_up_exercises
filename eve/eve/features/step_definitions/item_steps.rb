Given(/^I have the following items:$/) do |items|
  items.hashes.each do |item|
    FactoryGirl.create(:item, item)
  end
end

When(/^I visit the items page$/) do
  visit "/items"
end
