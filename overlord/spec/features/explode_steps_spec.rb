require_relative '../spec_helper.rb'
include OverlordTest

When(/^I enter the wrong deactivation code three times$/) do
  def enter_wrong_code
    fill_in "code", with: "1111"
    click_button "submit"
  end
  (1..3).each { enter_wrong_code }
end

Then(/^the status indicator shows as detonated$/) do
  expect(page).to have_content("Bomb has been detonated")
end

Then(/^the buttons do not work$/) do
  expect(page).to have_button("submit", disabled: true)
end
