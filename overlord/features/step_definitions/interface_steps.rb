# sad path
Given(/^an interface$/) do
  visit("http://localhost:4567/")
end

Then(/^I have the ability to enter an activation code$/) do
  fill_in('code', with: "foobar")
end

Given(/^The bomb's active state is true$/) do
  visit("http://localhost:4567/")
  fill_in('code', with: "1234")
  click_button("submit")
  expect(page).to have_content('BOMB ACTIVE')
end

Given(/^I enter the correct activation code into a text field$/) do
  fill_in('code', with: "1234")
  click_button("submit")
end

Then(/^nothing should happen$/) do
  expect(page).to have_content('BOMB ACTIVE')
end

Given(/^the bomb has been detonated$/) do
  visit("http://localhost:4567/")

  fill_in('code', with: "1234")
  click_button("submit")

  3.times do
    fill_in('code', with: "foo")
    click_button("submit")
  end
  expect(page).to have_content('BOMB DETONATED')
end

Then(/^the interface should no longer respond to user input$/) do
  fill_in('code', with: "1234")
  click_button("submit")
  expect(page).to have_content('BOMB DETONATED')
end

# happy path
Given(/^I have entered the correct activation code into a text field$/) do
  visit("http://localhost:4567/")
  fill_in('code', with: "1234")
end

Given(/^the bomb's active state is false$/) do
  expect(page).to have_content('BOMB INACTIVE')
end

When(/^I submit the form$/) do
  click_button("submit")
end

Then(/^the bomb active state should become true$/) do
  expect(page).to have_content('BOMB ACTIVE')
end

Given(/^I have an active bomb$/) do
  visit("http://localhost:4567/")
  fill_in('code', with: "1234")
  click_button("submit")
  expect(page).to have_content('BOMB ACTIVE')
end

Given(/^I enter the correct deactivation code$/) do
  fill_in('code', with: "0000")
  click_button("submit")
end

Then(/^the bomb state should become inactive$/) do
  expect(page).to have_content('BOMB INACTIVE')
end

Given(/^I activate the bomb$/) do
  visit("http://localhost:4567/")
  fill_in('code', with: "1234")
  click_button("submit")
  expect(page).to have_content('BOMB ACTIVE')
end

Given(/^I enter the incorrect deactivation code (\d+) times$/) do |attempts|
  attempts.to_i.times do
    fill_in('code', with: "foo")
    click_button("submit")
  end
end

Then(/^the bomb should detonate$/) do
  expect(page).to have_content('BOMB DETONATED')
end

Given(/^an inactive bomb$/) do
  visit("http://localhost:4567/")
end

Then(/^the interface should display BOMB DEACTIVATED$/) do
  expect(page).to have_content('BOMB INACTIVE')
end

Given(/^an active bomb$/) do
  visit("http://localhost:4567/")
  fill_in('code', with: "1234")
  click_button("submit")
end

Then(/^the interface should display BOMB ACTIVE$/) do
  expect(page).to have_content('BOMB ACTIVE')
end

# bad path

Given(/^I have activated the bomb$/) do
  visit("http://localhost:4567/")
  fill_in('code', with: "1234")
  click_button("submit")
  expect(page).to have_content('BOMB ACTIVE')
end

Given(/^entering the incorrect deactivation code results in a message$/) do
  fill_in('code', with: "asdf")
  click_button("submit")
  expect(page).to have_content('WRONG DEACTIVATION CODE ENTERED')
end