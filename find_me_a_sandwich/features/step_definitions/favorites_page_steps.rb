Given(/^a user that isn't me has meals saved to favorites$/) do
  merchant = FactoryGirl.create(:merchant, name: "FOO")
  menu = FactoryGirl.create(:menu, name: "foobar", merchant_id: merchant.id)

  @other_user = FactoryGirl.create(
    :user, email: "foo@example.com", password: "testtest"
  )

  @menu_item_1 = FactoryGirl.create(
    :menu_item, name: "barbaz A", menu_id: menu.id, menu_group: "foogroup"
  )

  @menu_item_2 = FactoryGirl.create(
    :menu_item, name: "barbaz B", menu_id: menu.id, menu_group: "bargroup"
  )

  FactoryGirl.create(
    :favorite, user: @other_user, menu_item: @menu_item_1
  )
end

When(/^I visit a users populated favorite meals list$/) do
  visit("/favorites/#{@other_user.id}/")
end

Then(/^I see meals they have added to the list$/) do
  expect(page).to have_content('barbaz A')
end

Then(/^I do not see meals they have not added to the list$/) do
  expect(page).not_to have_content('barbaz B')
end

When(/^I visit my favorite meals list$/) do
  visit("/favorites/#{@user.id}/")
end

Then(/^I see meals I have added to the list$/) do
  expect(page).to have_content('barbaz')
end

Then(/^I do not see meals I have not added to the list$/) do
  expect(page).not_to have_content('foobaz')
end
