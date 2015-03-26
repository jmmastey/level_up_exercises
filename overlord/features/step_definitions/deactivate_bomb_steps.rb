And(/^it has been activated$/) do
  step 'I enter the correct code in the code field'
  step 'I click on the activate button'
  step 'I should be redirected to a page with an active bomb'
end
