Feature: Adding coupons to existing cart
  As a user 
  I want to be able to add coupons to my shopping cart
  So that I can get a good deal

  Scenario: I can add a valid coupon
  Given I enter a valid coupon's information in my shopping cart
  When I click add
  Then I should see a message indicating the coupon was successfully added
  And I should see it listed amongst other valid coupons entered and accepted

  Scenario: I should be able to remove an added coupon
  Given I have added a valid coupon to my shopping cart
  When I click on the delete link on the coupon in the list
  Then the coupon is deleted from the list

  Scenario: Adding or deleting a coupon updates item prices
  Given I add or delete a valid coupon to or from my shopping cart
  Then the prices of relevant items already in my shopping cart should be updated

  Scenario: Adding or deleting a coupon affects the prices of items added in the future
  Given I add or delete a valid coupon to or from my shopping cart
  When I add new items to my shopping cart
  Then their prices should or should not respectively take into account the added or deleted coupon if relevant

  Scenario: I cannot add a coupon twice
  Given I have added a valid coupon to my shopping cart
  When I try to add the same coupon again
  Then I see an error message telling me that I cannot add the same coupon again
