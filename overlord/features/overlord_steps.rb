Given /I visit the overlord page/ do
  visit ("/")
end

When /I type in the right activation code/ do 
  fill_in("activation_code", with: "2342")
end

And /I click activate/ do
  click_button("Activate")
end

Then /I should see the bomb status as active/ do
  expect(page).to have_content "Status: The bomb is active"
end

Given /I visit the activate page/ do
  visit ("/activate")
end


When /I type in the right deactivation code/ do 
  fill_in("deactivation_code", with: "0000")
end

And /I click deactivate/ do
  click_button("Deactivate")
end

Then /I should see the bomb status as inctive/ do
  expect(page).to have_content "Status: The bomb is inactive"
end