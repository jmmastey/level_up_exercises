Feature:
  As an avid online buyer
  I want to start buying groceries
  and add them to a shopping cart
  that will provide functionality
  similar to a brick and mortar store

Scenario:
  Given I have not made a purchase
  When I check my cart status
  Then my cart should be empty

Scenario: Add Item to Cart
  Given I have selected an item
  When I click add to cart
  Then the cart should should have the item

Scenario: Remove Item from cart
  Given I want to remove an item
  When I click delete
  And click update order
  Then the cart should not have the item

Scenario: Change Quantity (add)
  Given I have five bags of sugar
  When I click + 
  Then the cart should have six bags

Scenario: Change Quantity (subtract)
  Given I have five bags of sugar
  When I click -
  Then the cart should have four bags

Scenario: Add Coupons
  Given
  When
  Then the total amount should reflect the coupon discount

Scenario: Expired Coupons
  Given I am ready to checkout
  When I apply the expired coupon
  And I click 
  Then I should see an error message

Scenario: View Shipping Estimates
  Given
  When
  Then

Scenario: Redirect to item page
  Given
  When
  Then

  #sad
  #bad