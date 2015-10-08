@Happy
Scenario: Entering a valid, unexpired coupon
  Given that I am on the cart page
  When I enter a valid, unexpired coupon
  And click on the submit button
  Then the coupon value is added to the order
  Then the orders' totals are recalculated

@Sad
Scenario: Entering a valid, expired coupon
  Given that I am on the cart page
  When I enter a valid, unexpired coupon
  And click on the submit button
  Then an informative error is displayed

@Sad
Scenario: Entering a invalid coupon
  Given that I am on the cart page
  When I enter a valid, unexpired coupon
  And click on the submit button
  Then an informative error is displayed

@Bad
Scenario: Entering a garbage coupon
  Given that I am on the cart page
  When I enter a valid, unexpired coupon
  And click on the submit button
  Then an informative error is displayed
