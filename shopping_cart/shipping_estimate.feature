Feature: Shipping estimate based on customer location

# SO HAPPY
Scenario: Destination ZIP code for calculating shipping
  Given anything
  When I am viewing the cart item page
  Then I see a ZIP code entry control
  And a message "Enter ZIP code for estimated shipping"

Scenario: Destination ZIP code filled in for authenticated users
  Given I am an authenticated user
  When I am viewing the cart item page
  Then I see my registered ZIP code in the ZIP code entry control

# SO SAD

Scenario: Enter invalid ZIP code
  Given I have an order with item subtotal $100 in my cart
  When I enter an invalid ZIP code in the ZIP code entry control
  Then I see an invalid ZIP code warning
  And I do not see a shipping line item

# SO BAD

