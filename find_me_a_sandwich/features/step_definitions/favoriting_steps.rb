Given(/^I view a menu item$/) do
  merchant = FactoryGirl.create(:merchant, name: "FOO")
  menu = FactoryGirl.create(:menu, name: "foobar", merchant_id: merchant.id)
  FactoryGirl.create(
    :menu_item, name: "barbaz", menu_id: menu.id, menu_group: "foogroup"
  )

  visit("/merchants/#{merchant.id}/")
end

When(/^I click the favorite button$/) do
  click_link("save to favorites")
end

Then(/^the menu item should save to my favorites$/) do
  visit("/favorites/")
  expect(page).to have_content('barbaz')
end
