Feature:
  As an avid online buyer
  I want to make purchases
  and add them to a shopping cart
  that will provide functionality
  similar to a brick and mortor store

Scenario: Empty Cart
  Given I have not made a purchase
  When I check my cart status
  Then my cart should be empty

Scenario: Add Items
  Given I have selected an item
  When I click add to cart
  Then the cart should should have the item

Scenario: Remove Items
  Given I am in the shopping cart
  When I click delete
  Then the cart should not have the item

Scenario: Change Quantity
  Given 
  When I click + 
  Then the cart should have two sodas

Scenario: Add Coupons
  Given
  When
  Then the new price should reflect...

Scenario: Expired Coupons
  Given
  When
  Then the 

Scenario: View Shipping Estimates
  Given
  When
  Then

Scenario: Redirect to item page
  Given
  When
  Then