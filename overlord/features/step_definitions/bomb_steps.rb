Given(/^"(.*?)" says "(.*?)"$/) do |selector_id, status_text|
  selector_id.should have_content(status_text)
end

Given(/^a bomb is "(.*?)"$/) do |arg1|
  Bomb.destroy_all
  @bomb = Bomb.create(activation_code: "12345",
                          deactivation_code: "0000",
                          detonation_time: 45,
                          status: arg1)
end

Given(/^I am looking at the page bomb$/) do
  visit "/"
  visit "/bomb/#{@bomb.id}"
end

Given(/^I am looking at the page "(.*?)"$/) do |arg1|
  visit "/bomb/#{@bomb.id}"
  visit "/bomb_#{arg1}"
end

Given(/^I start the app$/) do
  visit "/"
end

When(/^I enter valid attributes$/) do
  find(:css, "#activation_code").set("1234")
  find(:css, "#deactivation_code").set("0000")
  find(:css, "#detonation_time").set("50")
  click_button "Create"
end

When(/^I enter invalid attributes$/) do
  find(:css, "#activation_code").set("abcd")
  find(:css, "#deactivation_code").set("ertw")
  find(:css, "#detonation_time").set("50")
  click_button "Create"
end

When(/^I enter right "(.*?)"$/) do |arg1|
  find(:css, "#" + "#{arg1}").set(@bomb[arg1])
  click_button status[arg1]["button"]
end

When(/^I enter wrong "(.*?)"$/) do |arg1|
  find(:css, "#" + "#{arg1}").set(@bomb[arg1] + @bomb[arg1].reverse)
  click_button status[arg1]["button"]
end

When(/^I enter invalid activation_code of "(.*?)"$/) do |arg1|
  find(:css, "#activation_code").set(arg1)
  click_button status["activation_code"]["button"]
end

When(/^I enter invalid deactivation_code of "(.*?)"$/) do |arg1|
  find(:css, "#deactivation_code").set(arg1)
  click_button status["deactivation_code"]["button"]
end

Then(/^the app should be redirected to bomb page$/) do
  page.should have_content("inactive")
end

Then(/^the app should not be redirected to bomb page$/) do
  page.should have_content("Activation Code")
end

Then(/^the bomb status is "(.*?)"$/) do |arg1|
  expect(find(:css, "#bomb_status").text).to eq(arg1.downcase)
end

Then(/^bomb should be "(.*?)"$/) do |arg1|
  expect(find(:css, "#bomb_status").text).to eq(arg1)
end
