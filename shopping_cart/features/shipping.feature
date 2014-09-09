Feature: User can enter shipping information for having item shipped
  As a user
  I want to be able to enter shipping information
  So that I can get the item delivered

  Scenario: Displays shipping estimates when information is entered
  Given I have entered valid shipping information
  When I click submit
  Then I see an estimate of the shipping cost

  Scenario: Cannot get an estimate without valid shipping information
  Given I have entered invalid shipping information
  Then I should not be able to click submit
  And I should see the errors highlighted

  Scenario: Cannot proceed to checkout without valid shipping information
  Given I have entered invalid shipping information
  Then I should not be able to proceed to checkout
  And I should see the errors highlighted
