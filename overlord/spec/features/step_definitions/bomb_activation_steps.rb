Given(/^I am in the home page$/) do
  visit '/'
  url = URI.parse(current_url).request_uri
  expect(url).to eq('/')
end

Then(/^I should see an overlord image$/) do
  expect(page.find("#overlord")["src"]).to have_content("overlord.png")
end

Then(/^should have a name Valentine's Bomb$/) do
  expect(page.find(".name")).to have_content("VALENTINE'S BOMB")
end

When(/^hovering on the Overlord image$/) do
  page.find('#overlord').trigger(:mouseover)
end

When(/^clicking the image$/) do
  page.find('#overlord').trigger(:click)
end

Then(/^I should be redirected to bomb activation page$/) do
  url = URI.parse(current_url).request_uri
  expect(url).to eq('/boot_device')
end

Then(/^should see a field for entering my code$/) do
  expect(page.find('#boot_code')).to be_truthy
end

Then(/^should see a submit button$/) do
  expect(page).to have_selector("button[type=submit]")
end

When(/^I will enter my boot code:$/) do |table|
  # table is a Cucumber::Ast::Table
  code = table.rows_hash
  fill_in "boot_code", :with => code[:code]
end

When(/^click the submit button$/) do
  page.find("button[type=submit]").trigger(:click)
end

Then(/^be redirected to the bomb creation page$/) do
  url = URI.parse(current_url).request_uri
  expect(url).to eq("/create_bomb")
end

Then(/^not be redirected to the bomb creation page$/) do
  url = URI.parse(current_url).request_uri
  expect(url).to_not eq("/create_bomb")
end

Then(/^remain on the boot device page$/) do
  url = URI.parse(current_url).request_uri
  expect(url).to eq('/boot_device')
end
