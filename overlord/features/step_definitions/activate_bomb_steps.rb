Given(/^there is a bomb$/) do
  step 'there is currently no bomb'
  step 'I enter an activation code in the activation field'
  step 'I enter a deactivation code in the deactivation field'
  step 'I click on the initialize button'
  step 'I should be redirected to a page with an inactive bomb'
end

And(/^I click on the activate button$/) do
  click_button('activate')
end
