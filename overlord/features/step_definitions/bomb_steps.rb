Given(/^I am not yet playing$/) do
end

Given(/^I have already activated the bomb(?: with codes "(.*?)" and "(.*?)")?$/) do |act, deact|
  act ||= "1234"
  deact ||= "1234"
  activate(act, deact)
end

Given(/^the bomb has already exploded$/) do
  activate("1234", "1234")
  attempt_bad_deactivation
end

When(/^I attempt to deactivate with the wrong code too many times$/) do
  attempt_bad_deactivation
end

def attempt_bad_deactivation
  Bomb::MAX_ATTEMPTS.times do
    fill_in("deactivation_code", with: "5678")
    click_button("Deactivate")
  end
end

def activate(act, deact)
  visit path_to("the inactivated page")
  page.should have_content("Enter your activation code")
  fill_in("activation_code", with: act)
  fill_in("deactivation_code", with: deact)
  click_button("Arm the bomb")
end
