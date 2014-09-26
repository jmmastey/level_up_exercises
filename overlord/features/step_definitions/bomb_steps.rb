Given(/^I am not yet playing$/) do
end

And(/^I have already activated the bomb$/) do
  visit path_to("the start page")
  page.should have_content("Enter your activation code")
  fill_in("activation_code", :with => "1234")
  fill_in("deactivation_code", :with => "1234")
  click_button("Arm the bomb")
end