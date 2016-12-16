Given(/^there are favorited meals in my favorites list$/) do
  merchant = FactoryGirl.create(:merchant, name: "FOO")
  menu = FactoryGirl.create(:menu, name: "foobar", merchant_id: merchant.id)
  menu_item = FactoryGirl.create(
    :menu_item, name: "barbaz", menu_id: menu.id, menu_group: "foogroup"
  )

  FactoryGirl.create(
    :menu_item, name: "foobaz", menu_id: menu.id, menu_group: "foogroup 2"
  )

  FactoryGirl.create(
    :favorite, user: @user, menu_item: menu_item
  )

  visit("/favorites/")
  expect(page).to have_content('barbaz')
end

When(/^I click the unfavorite button$/) do
  click_link("remove from favorites")
end

Then(/^the meal should be removed from my favorites list$/) do
  visit("/favorites/")
  expect(page).not_to have_content('barbaz')
end
