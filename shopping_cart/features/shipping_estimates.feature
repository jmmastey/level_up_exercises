Feature: Shipping

Given I am on the checkout page
  When I enter my address
  And I press the 'Estimate Shipping' button
  Then I should see 'Shipping cost is:'

Given I am on the checkout page
  When I enter my address
  And I press the 'Estimate Shipping' button
  Then I should see 'Shipping cost is:'

Given I am on the checkout page
  When I enter my address
  And I check 'next-day air'
  And I press the 'Estimate Shipping' button
  Then I should see 'Shipping cost is:'

Given I am on the checkout page
  When I enter '60610' for zipcode
  Then I should see 'State: IL'

