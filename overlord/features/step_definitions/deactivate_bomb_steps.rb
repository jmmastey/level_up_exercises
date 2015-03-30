And(/^it has been activated$/) do
  step 'I enter the correct activation code in the code field'
  step 'I click on the activate button'
  step 'I should be redirected to a page with an active bomb'
end

And(/^I click on the deactivate button$/) do
  click_button('deactivate')
end

When(/^I deactivate the bomb incorrectly three times$/) do
  step 'I enter an incorrect deactivation code in the code field'
  step 'I click on the deactivate button'
  step 'I enter an incorrect deactivation code in the code field'
  step 'I click on the deactivate button'
  step 'I enter an incorrect deactivation code in the code field'
  step 'I click on the deactivate button'
end
